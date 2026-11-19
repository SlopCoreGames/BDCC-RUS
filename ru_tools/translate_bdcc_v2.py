#!/usr/bin/env python3
"""
BDCC Pass 2 comprehensive translator (GDScript + multiline .tscn).
Covers rooms/floors, HUD/UI, perks/items/status effects/options,
ModularDialogue, SexEngine, nested RNG.pick/ch1/ch2/ternary/str(),
and all text-returning methods while preserving IDs and syntax.
"""
import json
import os
import re
import sys
import time
import urllib.request

sys.path.insert(0, r"G:\Projects\Liliths_Throne_RU\ru_tools")
from translate_lt import (  # noqa: E402
    adaptive_thermal_guard,
    get_gpu_telemetry,
    get_nvapi_hotspot_temp,
    record_energy_sample,
)

REPO_ROOT = r"G:\Projects\BDCC_RU"
TOOLS_DIR = os.path.join(REPO_ROOT, "ru_tools")
CACHE_FILE = os.path.join(TOOLS_DIR, "tm_cache_bdcc.json")
QUEUE_FILE = os.path.join(TOOLS_DIR, "queue_bdcc_v2.json")
PROGRESS_FILE = os.path.join(TOOLS_DIR, "progress_bdcc_v2.json")
API_URL = "http://127.0.0.1:8080/v1/chat/completions"
MODEL = "gemma-4-26b-abliterated"

# Mask order: [[...]] BEFORE [...], then {...}, then escapes/printf
DOUBLE_BRACKET_RE = re.compile(r"\[\[[^\]\n]+\]\]")
BRACE_RE = re.compile(r"\{[^{}\n]+\}")
BBCODE_RE = re.compile(r"\[[^\[\]\n]+\]")
FMT_RE = re.compile(r"(?:\\n|\\t|\\\"|%(?:\d+\$)?[-+0 #]*\d*(?:\.\d+)?[sdfxXoc]|\\u[0-9a-fA-F]{4})")
MASK_ANY_RE = re.compile(r"@@[DBTF]\d+@@")

ALLOWED_EXTRA = set("—–…«»“”‘’•·°×±§©®™€£¥№²³½¼¾♥♡★☆♪♫→←↑↓\u00a0\u200b\u2011\u2026\u2013\u2014")

TSCN_PROPS = {
    "text",
    "bbcode_text",
    "placeholder_text",
    "hint_tooltip",
    "window_title",
    "dialog_text",
    "roomName",
    "roomDescription",
    "blindRoomDescription",
    "propertyName",
    "myTooltipTitle",
    "myTooltipDesc",
    "contentName",
    "contentDesc",
    "labelText",
    "collapseName",
    "ActionName",
    "lootAroundMessage",
}

BLOCKED_FUNCS = {
    "getFormIDs",
    "getSupportedSexTypes",
    "getTags",
    "getRequiredPerks",
    "getItemTags",
    "getSpecies",
    "getFetishes",
    "saveData",
    "loadData",
    "getAnimData",
    "getAnimation",
    "getSceneID",
    "getID",
    "getFlag",
    "setFlag",
}

BLOCKED_CALLS = {
    "print",
    "printerr",
    "prints",
    "printraw",
    "push_error",
    "push_warning",
    "assert",
    "throwError",
    "getFlag",
    "setFlag",
    "getModuleFlag",
    "setModuleFlag",
    "getModule",
    "getCharacter",
    "addCharacter",
    "removeCharacter",
    "playAnimation",
    "aimCamera",
    "aimCameraAndSetLocName",
    "hasItemID",
    "createItem",
    "createScene",
    "runScene",
    "hasEffect",
    "addEffect",
    "removeEffect",
    "hasPerk",
    "hasTag",
    "connect",
    "emit_signal",
    "load",
    "preload",
    "has",
    "get_node",
    "has_method",
    "call",
    "call_deferred",
    "tr",
}

# Funcs whose return/append prose should be extracted
TEXT_FUNCS = {
    "getVisibleName",
    "getVisibleDescription",
    "getVisibleDesc",
    "getDescription",
    "getSmallDescription",
    "getMoreDescription",
    "getTooltip",
    "getName",
    "getShortName",
    "getTitle",
    "getText",
    "getLines",
    "getAttackName",
    "getMessage",
    "getCategoryName",
    "getBuffDescription",
    "getDetails",
    "getEffectDesc",
    "getEffectName",
    "getStatusDesc",
    "getStackName",
    "getBegDialogue",
    "getSlaveReaction",
    "generateTransformText",
    "getProgress",
    "getProgressText",
    "getActionName",
    "getActionDesc",
    "getFailMessage",
    "getSuccessMessage",
    "getFightIntro",
    "getBodypartTooltipName",
    "getBodypartTooltipInfo",
    "getTakingOffStringLong",
    "getTakingOffString",
    "getPuttingOnStringLong",
    "getPuttingOnString",
    "getForcedOnMessage",
    "getRequirementText",
    "getNpcOwnerDialogueLines",
    "getDevCommentary",
    "getBidderOutbidReactions",
    "getPickableAttributes",
    "getUpgrades",
    "getTrainText",
    "getDesc",
    "getKinks",
    "getCompletedDesc",
    "getStartConditions",
    "reactRestraint",
    "interestVerbalReaction",
    "reactToCommand",
    "getChangeableOptions",
    "doAction",
    "doActionSimple",
    "getActions",
    "onAct",
    "execute",
    "_doAttack",
    "main_do",
    "sex_processTurn",
    "getForms",
    "getLewdName",
    "getLewdAdjective",
    "getLewdSizeAdjective",
    "getLewdStraponName",
    "getThicknessAdjective",
    "getFeminityAdjective",
    "getUndressMessage",
    "getLoosenessString",
    "getFluidLewdName",
    "getOfficialName",
    "getVisibleTime",
}

# Call arg extraction table: name -> tuple of 0-based arg indices (or "all", "values_list")
CALL_ARG_RULES = {
    "say": (0,),
    "sayn": (0,),
    "saynn": (0,),
    "sayLine": (0,),
    "sayParsed": (0,),
    "sayPresenter": (0,),
    "taviSpeak": (0,),
    "formatSay": (0,),
    "addText": (0,),
    "addTextRaw": (0,),
    "addTextTopBottom": (0,),
    "addTextTopBottomNotRaw": (0,),
    "addMessage": (0,),
    "talkOwner": (0,),
    "talkPC": (0,),
    "showAlert": (0,),
    "printLine": (0,),
    "setLocationName": (0,),
    "add_item": (0,),
    "form": (0,),
    "addLines": (0,),
    "addTextPick": (0,),
    "addTextRawPick": (0,),
    "talk": (1,),
    "talkCharID": (1,),
    "talkText": (1,),
    "talkAction": (1,),
    "addButton": (0, 1),
    "addDisabledButton": (0, 1),
    "addButtonWithChecks": (0, 1),
    "addExtraButton": (0, 1),
    "addButtonUnlessLate": (0, 1, 4),
    "addButtonAt": (1, 2),
    "addDisabledButtonAt": (1, 2),
    "addButtonWithChecksAt": (1, 2),
    "addExtraButtonAt": (1, 2),
    "addDisabledAction": (0, 1),
    "addStartAction": (1, 2),
    "newCompFile": (0, 1),
    "ch1": "all",
    "ch2": "all",
}

ASSIGN_PROPS = {
    "text",
    "texts",
    "lines",
    "resultLines",
    "variants",
    "visibleName",
    "name",
    "description",
    "desc",
    "tooltip",
    "hint_tooltip",
    "title",
    "label",
    "subtitle",
    "header",
    "activityName",
    "activityDesc",
    "roomName",
    "roomDescription",
    "message",
    "msg",
    "result",
    "res",
    "output",
    "theText",
    "info",
    "newText",
}

DICT_DISPLAY_KEYS = {
    '"name"',
    '"description"',
    '"desc"',
    '"text"',
    '"title"',
    '"tooltip"',
    '"visibleName"',
    '"label"',
    '"subtitle"',
    '"header"',
    '"buttonName"',
    '"buttonDesc"',
    "DBText",
}

PRIORITY_ORDER = [
    ("Game/World/Floors/", 0),
    ("Game/PlayerPanel", 1),
    ("Game/UI/", 1),
    ("UI/", 1),
    ("Game/Options/", 2),
    ("Skills/", 2),
    ("StatusEffect/", 2),
    ("Inventory/", 2),
    ("Species/", 2),
    ("Game/MainScene.gd", 2),
    ("Characters/", 3),
    ("Scenes/", 3),
    ("Events/", 3),
    ("Quests/", 3),
    ("Attacks/", 3),
    ("Game/Gameplay/", 4),
    ("Game/Science/", 4),
    ("Game/Transformation/", 4),
    ("Game/LustCombat/", 4),
    ("Game/SlaveAuction/", 4),
    ("Player/", 4),
    ("Modules/", 5),
    ("Game/DomRoute/", 6),
    ("Game/PlayerSlavery/", 6),
    ("Game/PlayerSlaverySoft/", 6),
    ("Game/NpcSlavery/", 6),
    ("Game/InteractionSystem/", 6),
    ("Game/SexEngine/", 7),
    ("Game/ModularDialogue/", 8),
]


def load_json(path, default):
    if os.path.exists(path):
        try:
            with open(path, "r", encoding="utf-8") as f:
                return json.load(f)
        except Exception:
            pass
    return default


def save_json_atomic(path, data):
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    os.replace(tmp, path)


def is_translatable_en(s: str, mode: str = "prose") -> bool:
    if not s or len(s.strip()) < 2:
        return False
    low = s.strip()
    if low.startswith(("res://", "user://", "http://", "https://", "ERROR:", "!RUNTIME", "!SYNTAX")):
        return False
    if "@@" in s:
        return False

    cleaned = DOUBLE_BRACKET_RE.sub(" ", low)
    cleaned = BRACE_RE.sub(" ", cleaned)
    cleaned = BBCODE_RE.sub(" ", cleaned)
    cleaned = FMT_RE.sub(" ", cleaned)

    # Skip strings already in Russian unless they contain a clear 3+ word English clause
    if re.search(r"[А-Яа-яЁё]", cleaned):
        return bool(re.search(r"\b[A-Za-z][a-z]+\s+[a-z]{2,}\s+[a-z]{2,}", cleaned))

    if not re.search(r"[A-Za-z]{2,}", cleaned):
        return False

    # Reject pure identifiers / paths / constants
    c_strip = cleaned.strip()
    if re.fullmatch(r"[a-z0-9_./:-]+", c_strip):
        # Allow a single lowercase word ONLY if inside display_label? No, IDs are lowercase!
        return False
    if re.fullmatch(r"[A-Z0-9_]+", c_strip):
        return False
    if re.fullmatch(r"[a-z]+[A-Z][A-Za-z0-9_]*", c_strip):
        return False
    if " " not in c_strip and ("_" in c_strip or "/" in c_strip):
        return False

    if mode == "display_label":
        # Single TitleCase words (e.g., "Stairs", "Never") or phrases allowed
        if " " not in c_strip:
            return bool(re.match(r"^[A-Z][a-z]{2,}", c_strip)) or bool(re.search(r"[.!?~]$", c_strip))
        return True

    # mode == "prose"
    if re.search(r"\b[A-Za-z]+\s+[A-Za-z']{2,}", c_strip):
        return True
    if re.search(r"[A-Za-z]{2,}[.!?~]$", c_strip):
        return True
    # Capitalized word (like "Thanks!" or "Stop" in Filler)
    if re.fullmatch(r"[A-Z][a-z]{2,}(?:[.!?~…]+)?", c_strip):
        return True
    return False


def mask_str(text: str) -> tuple[str, dict]:
    masks = {}
    cnt = 0

    def repl(prefix):
        def _inner(m):
            nonlocal cnt
            k = f"@@{prefix}{cnt}@@"
            masks[k] = m.group(0)
            cnt += 1
            return k
        return _inner

    masked = DOUBLE_BRACKET_RE.sub(repl("D"), text)
    masked = BRACE_RE.sub(repl("B"), masked)
    masked = BBCODE_RE.sub(repl("T"), masked)
    masked = FMT_RE.sub(repl("F"), masked)
    return masked, masks


def unmask_str(text: str, masks: dict) -> str:
    for k, v in masks.items():
        text = text.replace(k, v)
    return text


def has_disallowed_unicode(orig: str, tr: str) -> bool:
    for ch in tr:
        o = ord(ch)
        if o < 128 or (0x0400 <= o <= 0x04FF) or (ch in ALLOWED_EXTRA):
            continue
        if ch not in orig:
            return True
    return False


def validate_translation(orig: str, masked_in: str, translated: str, masks: dict) -> bool:
    if not translated:
        return False
    if "Контекст:" in translated or "Context:" in translated or "```" in translated:
        return False
    if any(translated.count(k) != masked_in.count(k) for k in masks):
        return False
    cleaned = translated
    for k in masks:
        cleaned = cleaned.replace(k, "")
    if "@@" in cleaned:
        return False
    if has_disallowed_unicode(orig, translated):
        return False
    return True


def call_llm(messages: list, json_mode: bool = False, max_tokens: int = 2048) -> str:
    adaptive_thermal_guard(max_temp=98.0, resume_temp=86.0)
    t0 = time.monotonic()
    temp_b, w_b = get_gpu_telemetry()
    body = {
        "model": MODEL,
        "messages": messages,
        "temperature": 0.25,
        "max_tokens": max_tokens,
        "chat_template_kwargs": {"enable_thinking": False},
    }
    if json_mode:
        body["response_format"] = {"type": "json_object"}
    req = urllib.request.Request(
        API_URL,
        data=json.dumps(body).encode("utf-8"),
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=300) as r:
        data = json.loads(r.read().decode("utf-8"))
    dt = time.monotonic() - t0
    temp_a, w_a = get_gpu_telemetry()
    avg_w = (w_b + w_a) / 2.0 if (w_b > 0 or w_a > 0) else 0.0
    record_energy_sample(dt, max(temp_b, temp_a), avg_w)
    return data["choices"][0]["message"]["content"].strip()


def split_outer_spaces(s: str) -> tuple[str, str, str]:
    m = re.match(r"^( *)(.*?)( *)$", s, re.S)
    return m.group(1), m.group(2), m.group(3)


def translate_single(text: str, context_note: str) -> str:
    lead, core, trail = split_outer_spaces(text)
    masked, masks = mask_str(core)
    if masks:
        rule = "Keep every exact placeholder token (such as @@D0@@, @@B1@@, @@T2@@, @@F3@@) unchanged; never add, duplicate, or remove any @@...@@ token. "
    else:
        rule = ""
    sys_p = (
        "You are an expert Russian literary translator for the explicit 18+ sci-fi RPG 'Broken Dreams Correctional Center (BDCC)'. "
        "Translate into natural, idiomatic, uncensored Russian. "
        + rule
        + "Output ONLY the Russian translation without outer quotes or notes."
    )
    usr_p = f"Context: {context_note}\nText:\n{masked}"
    for _ in range(3):
        try:
            out = call_llm([{"role": "system", "content": sys_p}, {"role": "user", "content": usr_p}], False, 1536)
            if validate_translation(core, masked, out, masks):
                unm = unmask_str(out, masks)
                return f"{lead}{unm.strip(' ')}{trail}"
        except Exception:
            time.sleep(1)
    return text


def translate_batch(items: list[str], tm: dict, context_note: str) -> list[str]:
    results = list(items)
    idx = 0
    while idx < len(items):
        batch_indices = []
        char_sum = 0
        while idx < len(items) and len(batch_indices) < 10:
            s = items[idx]
            if s in tm and validate_translation(s, s, tm[s], {}):
                # Re-validate cached result has no disallowed unicode / @@
                if "@@" not in tm[s] and not has_disallowed_unicode(s, tm[s]):
                    results[idx] = tm[s]
                    idx += 1
                    continue
            if batch_indices and char_sum + len(s) > 1200:
                break
            batch_indices.append(idx)
            char_sum += len(s)
            idx += 1

        if not batch_indices:
            continue
        if len(batch_indices) == 1:
            i = batch_indices[0]
            res_i = translate_single(items[i], context_note)
            results[i] = res_i
            if res_i != items[i]:
                tm[items[i]] = res_i
            continue

        masked_map = {}
        masks_map = {}
        outer_ws = {}
        any_masks = False
        for pos, orig_i in enumerate(batch_indices):
            lead, core, trail = split_outer_spaces(items[orig_i])
            m_txt, m_dict = mask_str(core)
            if m_dict:
                any_masks = True
            k_pos = str(pos)
            masked_map[k_pos] = m_txt
            masks_map[k_pos] = (m_txt, m_dict)
            outer_ws[k_pos] = (lead, core, trail)

        rule = (
            "CRITICAL: Keep every exact placeholder token (such as @@D0@@, @@B1@@, @@T2@@, @@F3@@) unchanged; never add, duplicate, or remove any @@...@@ token."
            if any_masks
            else "Translate cleanly without adding any special markers or explanations."
        )
        sys_p = (
            "You are an expert Russian literary translator for the explicit 18+ sci-fi RPG 'Broken Dreams Correctional Center (BDCC)'. "
            "Translate every string in the JSON object into natural, idiomatic, uncensored Russian. "
            "Return ONLY a JSON object with the exact same numeric string keys. "
            + rule
        )
        usr_p = f"Context: {context_note}\nJSON:\n{json.dumps(masked_map, ensure_ascii=False)}"
        ok = False
        for _ in range(2):
            try:
                raw = call_llm([{"role": "system", "content": sys_p}, {"role": "user", "content": usr_p}], True, 2048)
                parsed = json.loads(raw)
                if isinstance(parsed, dict) and all(str(p) in parsed for p in range(len(batch_indices))):
                    all_good = True
                    temp_out = {}
                    for pos, orig_i in enumerate(batch_indices):
                        kp = str(pos)
                        val = str(parsed[kp])
                        m_in, m_dict = masks_map[kp]
                        lead, core, trail = outer_ws[kp]
                        if not validate_translation(core, m_in, val, m_dict):
                            all_good = False
                            break
                        unm = unmask_str(val, m_dict)
                        temp_out[orig_i] = f"{lead}{unm.strip(' ')}{trail}"
                    if all_good:
                        for orig_i, final_s in temp_out.items():
                            results[orig_i] = final_s
                            if final_s != items[orig_i]:
                                tm[items[orig_i]] = final_s
                        ok = True
                        break
            except Exception:
                pass
        if not ok:
            for orig_i in batch_indices:
                res_i = translate_single(items[orig_i], context_note)
                results[orig_i] = res_i
                if res_i != items[orig_i]:
                    tm[items[orig_i]] = res_i
    return results


def sanitize_gd_literal(tr: str, orig_raw: str) -> str:
    tr = tr.replace("\r\n", "\n").replace("\n", "\\n")
    out = []
    i = 0
    while i < len(tr):
        if tr[i] == "\\" and i + 1 < len(tr):
            out.append(tr[i : i + 2])
            i += 2
        elif tr[i] == '"':
            out.append('\\"')
            i += 1
        else:
            out.append(tr[i])
            i += 1
    return "".join(out)


# =====================================================================
# GDScript Syntax-Aware Extractor
# =====================================================================

def scan_gd_spans(src: str, rel_path: str) -> list[tuple[int, int, str]]:
    """
    Scan GDScript and return non-overlapping sorted (start, end, inner_raw) spans
    strictly representing translatable user-facing text.
    """
    n = len(src)
    # 1. Pre-index every comment, triple string, and double-quoted literal
    #    Also map char -> token info cleanly
    in_code = [True] * n
    str_literals = {}  # start_quote_idx -> (inner_start, inner_end, close_quote_idx)
    end_to_lit = {}    # close_quote_idx -> start_quote_idx

    i = 0
    while i < n:
        ch = src[i]
        if ch == "#":
            nl = src.find("\n", i)
            end = n if nl == -1 else nl
            for k in range(i, end):
                in_code[k] = False
            i = end
            continue
        if src.startswith('"""', i) or src.startswith("'''", i):
            q3 = src[i : i + 3]
            end = src.find(q3, i + 3)
            end = n if end == -1 else end + 3
            for k in range(i, end):
                in_code[k] = False
            i = end
            continue
        if ch == '"':
            j = i + 1
            closed = False
            while j < n:
                if src[j] == "\\":
                    j += 2
                elif src[j] == '"':
                    closed = True
                    break
                elif src[j] == "\n":
                    break
                else:
                    j += 1
            if closed:
                str_literals[i] = (i + 1, j, j)
                end_to_lit[j] = i
                for k in range(i, j + 1):
                    in_code[k] = False
                i = j + 1
                continue
        elif ch == "'":
            j = i + 1
            closed = False
            while j < n:
                if src[j] == "\\":
                    j += 2
                elif src[j] == "'":
                    closed = True
                    break
                elif src[j] == "\n":
                    break
                else:
                    j += 1
            if closed:
                for k in range(i, j + 1):
                    in_code[k] = False
                i = j + 1
                continue
        i += 1

    # Compute blocked char intervals for functions in BLOCKED_FUNCS
    blocked_func_ranges = []
    func_matches = list(re.finditer(r"^\s*func\s+([A-Za-z0-9_]+)\s*\(", src, re.M))
    func_blocks = []  # (func_name, body_start, body_end)
    for idx_f, fm in enumerate(func_matches):
        fname = fm.group(1)
        b_start = fm.end()
        b_end = func_matches[idx_f + 1].start() if idx_f + 1 < len(func_matches) else n
        func_blocks.append((fname, b_start, b_end))
        if fname in BLOCKED_FUNCS:
            blocked_func_ranges.append((fm.start(), b_end))

    def is_in_blocked_func(pos: int) -> bool:
        for s0, e0 in blocked_func_ranges:
            if s0 <= pos < e0:
                return True
        return False

    def skip_ws_and_comments(p: int) -> int:
        while p < n:
            if src[p] in " \t\r\n":
                p += 1
            elif src[p] == "#":
                nl = src.find("\n", p)
                p = n if nl == -1 else nl + 1
            else:
                break
        return p

    def find_matching_close(open_pos: int, open_ch: str, close_ch: str) -> int:
        p = open_pos + 1
        depth = 1
        while p < n and depth > 0:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if not in_code[p]:
                p += 1
                continue
            c = src[p]
            if c == open_ch:
                depth += 1
            elif c == close_ch:
                depth -= 1
                if depth == 0:
                    return p
            p += 1
        return n - 1

    def prev_non_ws(p: int) -> int:
        p -= 1
        while p >= 0:
            if src[p] in " \t\r\n":
                p -= 1
            else:
                # If inside a # comment on a line, back up to #
                break
        return p

    def is_unsafe_literal_context(lit_start: int, lit_close: int, region_start: int) -> bool:
        if is_in_blocked_func(lit_start):
            return True
        # Preceded by ==, !=, in [, etc.
        pb = prev_non_ws(lit_start)
        if pb >= 1 and src[pb - 1 : pb + 1] in ("==", "!="):
            return True
        # Followed by ==, !=, or ':' (dict key)
        na = skip_ws_and_comments(lit_close + 1)
        if na < n and src[na] == ":":
            return True
        if na + 1 < n and src[na : na + 2] in ("==", "!="):
            return True
        # Inside `... in [...]`
        if pb >= 0 and src[pb] in "[,":
            # Walk back to opening '['
            scan = lit_start - 1
            d = 0
            while scan >= max(0, region_start - 200):
                if scan in end_to_lit:
                    scan = end_to_lit[scan] - 1
                    continue
                if not in_code[scan]:
                    scan -= 1
                    continue
                if src[scan] == "]":
                    d += 1
                elif src[scan] == "[":
                    if d == 0:
                        before_brk = src[max(0, scan - 12) : scan].rstrip()
                        if before_brk.endswith(" in") or before_brk.endswith("in"):
                            if re.search(r"\bin\s*$", before_brk):
                                return True
                        break
                    d -= 1
                scan -= 1
        # Check ternary condition: after ` if ` and before ` else ` at same paren depth
        scan = lit_start - 1
        d = 0
        saw_if = False
        while scan >= max(0, region_start):
            if scan in end_to_lit:
                scan = end_to_lit[scan] - 1
                continue
            if not in_code[scan]:
                scan -= 1
                continue
            c = src[scan]
            if c in ")]}":
                d += 1
            elif c in "([{":
                if d == 0:
                    break
                d -= 1
            elif d == 0:
                if src[max(0, scan - 4) : scan + 1] == "else" and (scan - 4 <= 0 or not src[scan - 5].isalnum()):
                    # We are AFTER else -> safe!
                    break
                if scan >= 1 and src[scan - 1 : scan + 1] == "if" and (scan - 2 < 0 or not (src[scan - 2].isalnum() or src[scan - 2] == "_")) and (scan + 1 >= n or not (src[scan + 1].isalnum() or src[scan + 1] == "_")):
                    saw_if = True
                    break
            scan -= 1
        if saw_if:
            # Verify there is a matching `else` ahead at same depth
            fwd = lit_close + 1
            d = 0
            while fwd < n:
                if fwd in str_literals:
                    fwd = str_literals[fwd][2] + 1
                    continue
                if not in_code[fwd]:
                    fwd += 1
                    continue
                c = src[fwd]
                if c in "([{":
                    d += 1
                elif c in ")]}":
                    if d == 0:
                        break
                    d -= 1
                elif c in ",\n" and d == 0:
                    break
                elif d == 0 and src.startswith("else", fwd) and (fwd == 0 or not src[fwd - 1].isalnum()) and (fwd + 4 >= n or not src[fwd + 4].isalnum()):
                    return True
                fwd += 1
        return False

    collected = {}  # (s, e) -> (raw_text, mode)

    def add_lit(q_pos: int, mode: str, region_start: int):
        s, e, close_q = str_literals[q_pos]
        if is_unsafe_literal_context(q_pos, close_q, region_start):
            return
        raw = src[s:e]
        if is_translatable_en(raw, mode):
            # Prefer display_label mode if either asks for it
            if (s, e) in collected and collected[(s, e)][1] == "display_label":
                return
            collected[(s, e)] = (raw, mode)

    def extract_expr(r_start: int, r_end: int, mode: str = "prose"):
        p = r_start
        while p < r_end:
            if p in str_literals:
                add_lit(p, mode, r_start)
                p = str_literals[p][2] + 1
                continue
            if not in_code[p]:
                p += 1
                continue
            # Check for blocked call or recursive RNG.pick / ch1 / ch2 inside expr
            if src[p].isalpha() or src[p] == "_":
                m_id = re.match(r"[A-Za-z_][A-Za-z0-9_]*", src[p:r_end])
                if m_id:
                    ident = m_id.group(0)
                    after_id = skip_ws_and_comments(p + len(ident))
                    if after_id < r_end and src[after_id] == "(":
                        close_p = find_matching_close(after_id, "(", ")")
                        if ident in BLOCKED_CALLS:
                            p = close_p + 1
                            continue
                        if ident == "Log":
                            p = close_p + 1
                            continue
                    p += len(ident)
                    continue
            p += 1

    def extract_call_args_ranges(open_p: int) -> list[tuple[int, int]]:
        args = []
        p = open_p + 1
        arg_s = p
        depth = 1
        while p < n and depth > 0:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if not in_code[p]:
                p += 1
                continue
            c = src[p]
            if c in "([{":
                depth += 1
            elif c in ")]}":
                depth -= 1
                if depth == 0:
                    args.append((arg_s, p))
                    break
            elif c == "," and depth == 1:
                args.append((arg_s, p))
                arg_s = p + 1
            p += 1
        return args

    # Pass A: function call extraction across entire file (respecting in_code!)
    call_re = re.compile(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*\(")
    for m in call_re.finditer(src):
        if not in_code[m.start()] or is_in_blocked_func(m.start()):
            continue
        cname = m.group(1)
        open_p = m.end() - 1
        # Make sure preceded by code/dot, not inside identifier
        if cname in CALL_ARG_RULES:
            # Skip method calls on Log etc.
            rule = CALL_ARG_RULES[cname]
            arg_ranges = extract_call_args_ranges(open_p)
            mode = "display_label" if cname in (
                "addButton", "addDisabledButton", "addButtonWithChecks", "addExtraButton",
                "addButtonUnlessLate", "addButtonAt", "addDisabledButtonAt",
                "addButtonWithChecksAt", "addExtraButtonAt", "addDisabledAction",
                "addStartAction", "setLocationName", "newCompFile",
            ) else "prose"
            if rule == "all":
                for rs, re_pos in arg_ranges:
                    extract_expr(rs, re_pos, mode)
            else:
                for ai in rule:
                    if ai < len(arg_ranges):
                        rs, re_pos = arg_ranges[ai]
                        extract_expr(rs, re_pos, mode)
        elif cname == "addAction":
            arg_ranges = extract_call_args_ranges(open_p)
            if "Game/SexEngine/" in rel_path.replace("\\", "/"):
                for ai in (2, 3):
                    if ai < len(arg_ranges):
                        extract_expr(arg_ranges[ai][0], arg_ranges[ai][1], "display_label")
            else:
                for ai in (1, 2):
                    if ai < len(arg_ranges):
                        extract_expr(arg_ranges[ai][0], arg_ranges[ai][1], "display_label")
        elif cname == "pick":
            # Check RNG.pick(...)
            pre = src[max(0, m.start() - 5) : m.start()]
            if pre.endswith("RNG."):
                arg_ranges = extract_call_args_ranges(open_p)
                if arg_ranges:
                    extract_expr(arg_ranges[0][0], arg_ranges[0][1], "prose")

    # Pass B: Assignments `(var )?(obj.)?prop (= | +=) rhs`
    # Scan line by line using in_code check
    assign_re = re.compile(
        r"^\s*(?:var\s+)?(?:[A-Za-z0-9_]+\.)?(" + "|".join(sorted(ASSIGN_PROPS)) + r")\s*(?::\s*String\s*)?\+?=\s*",
        re.M,
    )
    for m in assign_re.finditer(src):
        if not in_code[m.start()] or is_in_blocked_func(m.start()):
            continue
        pname = m.group(1)
        mode = "display_label" if pname in ("visibleName", "name", "roomName", "activityName", "title", "label", "header") else "prose"
        # Scan RHS expression until top-level newline / end of multiline bracket/paren
        p = m.end()
        d = 0
        while p < n:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if not in_code[p]:
                p += 1
                continue
            c = src[p]
            if c in "([{":
                d += 1
            elif c in ")]}":
                if d == 0:
                    break
                d -= 1
            elif c == "\n" and d == 0:
                break
            p += 1
        extract_expr(m.end(), p, mode)

    # Pass C: Dictionary display keys: `"name": <expr>`, `DBText: <expr>`, or `{name = <expr>, text = <expr>}`
    dict_re = re.compile(r'(?:("name"|"description"|"desc"|"text"|"title"|"tooltip"|"visibleName"|"label"|"subtitle"|"header"|"buttonName"|"buttonDesc"|DBText)\s*:\s*|\b(name|desc|description|text|title|tooltip|buttonName|buttonDesc)\s*=\s*(?="))')
    for m in dict_re.finditer(src):
        if is_in_blocked_func(m.start()):
            continue
        key_name = m.group(1) or m.group(2)
        # m.start() is on `"` or identifier; ensure line isn't commented
        line_s = src.rfind("\n", 0, m.start()) + 1
        if not in_code[line_s] and src[line_s:m.start()].lstrip().startswith("#"):
            continue
        val_s = m.end()
        # Find end of dict entry at depth 0
        p = val_s
        d = 0
        while p < n:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if not in_code[p]:
                p += 1
                continue
            c = src[p]
            if c in "([{":
                d += 1
            elif c in ")]}":
                if d == 0:
                    break
                d -= 1
            elif c == "," and d == 0:
                break
            p += 1
        mode = "display_label" if key_name in ('"name"', '"title"', '"visibleName"', '"label"', '"buttonName"', "DBText", "name", "title", "buttonName") else "prose"
        extract_expr(val_s, p, mode)

    # Pass D: GlobalOptions `"values": [ [id, "Label"], ... ]`
    val_list_re = re.compile(r'"values"\s*:\s*\[')
    for m in val_list_re.finditer(src):
        brk_open = m.end() - 1
        brk_close = find_matching_close(brk_open, "[", "]")
        p = brk_open + 1
        while p < brk_close:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if in_code[p] and src[p] == "[":
                inner_close = find_matching_close(p, "[", "]")
                # Split args inside [id, "Label"]
                items_ranges = extract_call_args_ranges(p)  # works identically up to ']'
                if len(items_ranges) >= 2:
                    extract_expr(items_ranges[1][0], items_ranges[1][1], "display_label")
                p = inner_close + 1
                continue
            p += 1

    # Pass E: Expanded text-returning methods -> `return <expr>` and `.append(<expr>)`
    for fname, b_start, b_end in func_blocks:
        if fname not in TEXT_FUNCS:
            continue
        mode = "display_label" if fname in ("getVisibleName", "getName", "getShortName", "getTitle", "getAttackName", "getCategoryName", "getActionName", "getStackName") else "prose"
        block = src[b_start:b_end]
        for rm in re.finditer(r"\breturn\b", block):
            r_pos = b_start + rm.end()
            if not in_code[b_start + rm.start()]:
                continue
            p = r_pos
            d = 0
            while p < b_end:
                if p in str_literals:
                    p = str_literals[p][2] + 1
                    continue
                if not in_code[p]:
                    p += 1
                    continue
                c = src[p]
                if c in "([{":
                    d += 1
                elif c in ")]}":
                    if d == 0:
                        break
                    d -= 1
                elif c == "\n" and d == 0:
                    break
                p += 1
            extract_expr(r_pos, p, mode)
        for am in re.finditer(r"\.append\s*\(", block):
            a_open = b_start + am.end() - 1
            if not in_code[b_start + am.start()]:
                continue
            a_close = find_matching_close(a_open, "(", ")")
            extract_expr(a_open + 1, a_close, mode)

    # Deduplicate / filter overlapping spans
    ordered = sorted((s, e, raw, m) for (s, e), (raw, m) in collected.items())
    clean = []
    last_e = -1
    for s, e, raw, _m in ordered:
        if s >= last_e:
            clean.append((s, e, raw))
            last_e = e
    return clean


# =====================================================================
# Multiline .tscn Extractor
# =====================================================================

def scan_tscn_spans(src: str) -> list[tuple[int, int, str]]:
    """
    Find single-line AND multiline string property spans in .tscn files
    for whitelisted UI/room properties.
    """
    spans = []
    n = len(src)
    i = 0
    while i < n:
        line_start = i
        nl = src.find("\n", i)
        line_end = n if nl == -1 else nl
        line = src[line_start:line_end].rstrip("\r")
        m = re.match(r'^([A-Za-z0-9_/]+)\s*=\s*"', line)
        if m:
            prop = m.group(1)
            q_open = line_start + m.end() - 1
            j = q_open + 1
            closed = False
            while j < n:
                if src[j] == "\\":
                    j += 2
                elif src[j] == '"':
                    closed = True
                    break
                else:
                    j += 1
            if closed:
                if prop in TSCN_PROPS:
                    raw_val = src[q_open + 1 : j]
                    norm_val = raw_val.replace("\r\n", "\n").replace("\n", "\\n")
                    if is_translatable_en(norm_val, "display_label"):
                        spans.append((q_open + 1, j, norm_val))
                next_nl = src.find("\n", j)
                i = n if next_nl == -1 else next_nl + 1
                continue
        i = n if nl == -1 else nl + 1
    return spans


def process_gd_file(rel_path: str, tm: dict, dry_run: bool = False) -> tuple[bool, list[str]]:
    fp = os.path.join(REPO_ROOT, rel_path)
    src = open(fp, "r", encoding="utf-8", errors="replace").read()
    spans = scan_gd_spans(src, rel_path)
    if not spans:
        return False, []
    texts = [t for _, _, t in spans]
    if dry_run:
        return True, texts
    translated = translate_batch(texts, tm, f"BDCC GDScript: {rel_path}")
    out = []
    pos = 0
    changed = False
    for (s, e, orig), tr in zip(spans, translated):
        out.append(src[pos:s])
        if tr != orig:
            out.append(sanitize_gd_literal(tr, orig))
            changed = True
        else:
            out.append(orig)
        pos = e
    out.append(src[pos:])
    if changed:
        eol = "\r\n" if "\r\n" in src else "\n"
        txt_out = "".join(out)
        with open(fp, "w", encoding="utf-8", newline="") as f:
            f.write(txt_out)
    return changed, texts


def process_tscn_file(rel_path: str, tm: dict, dry_run: bool = False) -> tuple[bool, list[str]]:
    fp = os.path.join(REPO_ROOT, rel_path)
    src = open(fp, "r", encoding="utf-8", errors="replace").read()
    spans = scan_tscn_spans(src)
    if not spans:
        return False, []
    texts = [t for _, _, t in spans]
    if dry_run:
        return True, texts
    translated = translate_batch(texts, tm, f"BDCC Scene/Rooms: {rel_path}")
    out = []
    pos = 0
    changed = False
    for (s, e, norm_orig), tr in zip(spans, translated):
        out.append(src[pos:s])
        if tr != norm_orig:
            out.append(sanitize_gd_literal(tr, norm_orig))
            changed = True
        else:
            out.append(src[s:e])
        pos = e
    out.append(src[pos:])
    if changed:
        txt_out = "".join(out)
        with open(fp, "w", encoding="utf-8", newline="") as f:
            f.write(txt_out)
    return changed, texts


def build_queue(done_set: set[str]) -> list[str]:
    items = []
    for dp, dn, fns in os.walk(REPO_ROOT):
        for skip in (".git", "ru_tools", "build", ".import", "AssetsSource", "addons"):
            if skip in dn:
                dn.remove(skip)
        for fn in fns:
            if not fn.endswith((".gd", ".tscn")):
                continue
            rel = os.path.relpath(os.path.join(dp, fn), REPO_ROOT).replace("\\", "/")
            if rel in done_set:
                continue
            items.append(rel)

    def prio(rel: str):
        if rel.endswith(".tscn"):
            # Prioritize World/Floors & UI first
            if rel.startswith("Game/World/Floors/"):
                return (0, 0, rel)
            return (0, 1, rel)
        for pfx, rank in PRIORITY_ORDER:
            if rel.startswith(pfx):
                return (1, rank, rel)
        return (1, 9, rel)

    items.sort(key=prio)
    return items


def run_dry_run():
    queue = build_queue(set())
    total_strings = 0
    files_with_work = 0
    by_ext = {".tscn": 0, ".gd": 0}
    samples = {}
    sample_targets = {
        "Game/World/Floors/MainHall.tscn",
        "Skills/Perk/StartNoHeat.gd",
        "Game/Options/GlobalOptions.gd",
        "Game/ModularDialogue/Fillers/DefaultFiller.gd",
        "Game/SexEngine/Reactions/DefaultReactions.gd",
        "Scenes/Intro/IntroScene.gd",
    }
    for rel in queue:
        if rel.endswith(".tscn"):
            ch, texts = process_tscn_file(rel, {}, dry_run=True)
            ext = ".tscn"
        else:
            ch, texts = process_gd_file(rel, {}, dry_run=True)
            ext = ".gd"
        if ch and texts:
            files_with_work += 1
            total_strings += len(texts)
            by_ext[ext] += len(texts)
            if rel in sample_targets:
                samples[rel] = texts[:12]

    print(f"DRY_RUN_QUEUE_TOTAL: {len(queue)} files scanned")
    print(f"DRY_RUN_WORK_FILES: {files_with_work} files have untranslated text")
    print(f"DRY_RUN_TOTAL_STRINGS: {total_strings:,} (.tscn={by_ext['.tscn']:,}, .gd={by_ext['.gd']:,})")
    for k in sorted(samples):
        print(f"\n--- SAMPLE: {k} (first {len(samples[k])}) ---")
        for s in samples[k]:
            print(" ", repr(s[:120]))


def main():
    if "--dry-run" in sys.argv:
        run_dry_run()
        return

    os.makedirs(TOOLS_DIR, exist_ok=True)
    prog = load_json(PROGRESS_FILE, {"done": []})
    done_set = set(prog.get("done", []))
    tm = load_json(CACHE_FILE, {})
    if "--rebuild-queue" in sys.argv or not os.path.exists(QUEUE_FILE):
        queue = build_queue(done_set)
        save_json_atomic(QUEUE_FILE, queue)
    else:
        queue = load_json(QUEUE_FILE, [])

    print(f"[BDCC_V2] Queue={len(queue)}, Done={len(done_set)}, TM={len(tm)}", flush=True)
    processed_since_save = 0

    while queue:
        rel = queue[0]
        t0 = time.monotonic()
        try:
            if rel.endswith(".tscn"):
                ch, _ = process_tscn_file(rel, tm, dry_run=False)
            else:
                ch, _ = process_gd_file(rel, tm, dry_run=False)
            dt = time.monotonic() - t0
            queue.pop(0)
            done_set.add(rel)
            prog["done"] = sorted(done_set)
            processed_since_save += 1
            if ch or processed_since_save % 25 == 0 or not queue:
                save_json_atomic(PROGRESS_FILE, prog)
                save_json_atomic(QUEUE_FILE, queue)
                save_json_atomic(CACHE_FILE, tm)
            if ch or len(queue) % 50 == 0 or not queue:
                hs, core, vram = get_nvapi_hotspot_temp()
                print(
                    f"[BDCC_V2] ({len(queue)} left | {len(done_set)} done) {rel} ({dt:.1f}s, ch={ch}) | TM={len(tm)} | HotSpot={hs:.1f}C",
                    flush=True,
                )
        except Exception as ex:
            print(f"  ERR {rel}: {ex}", flush=True)
            queue.pop(0)


if __name__ == "__main__":
    main()
