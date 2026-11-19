#!/usr/bin/env python3
"""
BDCC Pass 3 surgical catcher (GDScript prose & display strings).
Catches remaining player-facing prose missed by Pass 2 whitelists
(e.g. Attacks/, Inventory/Items useInCombat, UI/ButtonChecks, static funcs,
multi-line perk '+' concatenations, Bodypart/transform/auction/character
notices, DomRoute recruits, DrugDen/MilkCafe/etc.) while strictly skipping
IDs, dict keys, subscript keys, == / != / in [...] comparisons, console
commands, resource paths, and debug/error strings.
"""
import os
import re
import sys
import time

sys.path.insert(0, r"G:\Projects\BDCC_RU\ru_tools")
from translate_bdcc_v2 import (  # noqa: E402
    BBCODE_RE,
    BRACE_RE,
    CACHE_FILE,
    DOUBLE_BRACKET_RE,
    FMT_RE,
    PRIORITY_ORDER,
    REPO_ROOT,
    TOOLS_DIR,
    get_nvapi_hotspot_temp,
    load_json,
    sanitize_gd_literal,
    save_json_atomic,
    translate_batch,
)

QUEUE_FILE_V3 = os.path.join(TOOLS_DIR, "queue_bdcc_v3.json")
PROGRESS_FILE_V3 = os.path.join(TOOLS_DIR, "progress_bdcc_v3.json")
QUEUE_FILE_V2 = os.path.join(TOOLS_DIR, "queue_bdcc_v2.json")

SKIP_DIR_PREFIXES = (
    "addons/",
    "UI/DebugUI/",
    "Game/SexEngine/Util/SexReactionEditor/",
)
SKIP_FILE_EXACT = {
    "Scenes/SimpleAnimPlayerScene.gd",
    "UI/TroubleshootingScreen/TroubleshootingScreen.gd",
}
SKIP_FILE_PREFIXES = (
    "Util/SubscribestarCsvConverter",
)

BLOCKED_FUNCS_V3 = {
    "getFormIDs",
    "getSupportedSexTypes",
    "getTags",
    "getRequiredPerks",
    "getItemTags",
    "getSpecies",
    "getFetishes",
    "saveData",
    "getAnimData",
    "getAnimation",
    "getSceneID",
    "getID",
    "playAnimation",
    "setupConsoleCommands",
}

BLOCKED_CALLS_V3 = {
    "addCommand",
    "print",
    "printerr",
    "prints",
    "printraw",
    "push_error",
    "push_warning",
    "assert",
    "throwError",
    "Log",
    "getFlag",
    "hasFlag",
    "clearFlag",
    "getModuleFlag",
    "clearModuleFlag",
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
    "get_node",
    "has_node",
    "has_method",
    "call",
    "call_deferred",
    "tr",
    "has",
    "erase",
    "get_meta",
    "set_meta",
    "get_shader_param",
    "set_shader_param",
    "is_in_group",
    "add_to_group",
    "loadVar",
    "saveVar",
    "getVar",
    "setVar",
    "addVar",
    "has_action",
    "is_action_pressed",
    "is_action_just_pressed",
    "PoolStringArray",
    "PoolByteArray",
    "PoolIntArray",
    "PoolRealArray",
}

TECH_PREFIXES = (
    "res://",
    "user://",
    "http://",
    "https://",
    "parameters/",
    "shader_param/",
    "org.",
    "ERROR:",
    "!RUNTIME",
    "!SYNTAX",
    "@@",
    "!No attack text",
    "error, let the developer know",
)

TECH_EXACT = {
    "error, let the developer know",
    "AnimationNode",
    "PoolStringArray",
}

SINGLE_TITLECASE_ALLOW_FILES = (
    "Characters/Dynamic/NpcRank.gd",
    "Game/PlayerSlaverySoft/Events/Approach/LockRestraint.gd",
)
SINGLE_TITLECASE_ALLOW_PREFIXES = (
    "Game/DomRoute/Recruits/",
)


def is_prose_v3(s: str, rel_path: str) -> bool:
    if not s or len(s.strip()) < 2:
        return False
    low = s.strip()
    if any(low.startswith(p) or p in low for p in TECH_PREFIXES if p in ("res://", "user://", "http://", "https://", "parameters/", "shader_param/", "org.", "@@")):
        return False
    if low.startswith(("ERROR:", "!RUNTIME", "!SYNTAX", "!No attack text")) or low in TECH_EXACT:
        return False
    if low == "trueOrFalse" or low == "flagID" or low == "moduleID" or low == "charID":
        return False

    cleaned = DOUBLE_BRACKET_RE.sub(" ", low)
    cleaned = BRACE_RE.sub(" ", cleaned)
    cleaned = BBCODE_RE.sub(" ", cleaned)
    cleaned = FMT_RE.sub(" ", cleaned).strip()

    if not cleaned:
        return False

    # Already Cyrillic? Skip unless a clear 4+ word lowercase English clause leaked inside
    if re.search(r"[А-Яа-яЁё]", cleaned):
        return bool(re.search(r"\b[a-z]{3,}(?:\s+[a-z]{2,}){3,}\b", cleaned))

    if not re.search(r"[A-Za-z]{2,}", cleaned):
        return False

    # Reject pure identifiers, constants, snake_case, paths
    if re.fullmatch(r"[a-z0-9_./:-]+", cleaned):
        return False
    if re.fullmatch(r"[A-Z0-9_]+", cleaned):
        return False
    if re.fullmatch(r"[a-z]+[A-Z][A-Za-z0-9_]*", cleaned):
        return False
    if " " not in cleaned and ("_" in cleaned or "/" in cleaned):
        return False
    if re.match(r"^(?:func |extends |class_name |var |const |signal |enum |Pool[A-Z]|AnimationNode)", cleaned):
        return False

    # 2+ English words separated by whitespace -> prose/sentence/phrase
    if re.search(r"\b[A-Za-z]{2,}\s+[A-Za-z']{2,}", cleaned):
        # Guard against Godot/type strings like "Invalid call" / shader / node types
        return True
    if re.search(r"[A-Za-z]{2,}[.!?~…]$", cleaned):
        return True

    # Single TitleCase display word (optionally hyphenated like Ring-gag, Drug-use) in whitelisted files
    norm_rel = rel_path.replace("\\", "/")
    if norm_rel in SINGLE_TITLECASE_ALLOW_FILES or norm_rel.startswith(SINGLE_TITLECASE_ALLOW_PREFIXES):
        if re.fullmatch(r"[A-Z][a-z]+(?:-[A-Za-z]+)*", cleaned):
            return True

    return False


def scan_gd_v3_spans(src: str, rel_path: str) -> list[tuple[int, int, str]]:
    """Scan GDScript for remaining untranslated user-facing strings with strict context guards."""
    n = len(src)
    in_code = [True] * n
    str_literals = {}
    end_to_lit = {}

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

    # Map blocked func blocks (including static func!)
    func_matches = list(re.finditer(r"^\s*(?:static\s+)?func\s+([A-Za-z0-9_]+)\s*\(", src, re.M))
    blocked_func_ranges = []
    func_sig_ranges = []
    for idx_f, fm in enumerate(func_matches):
        fname = fm.group(1)
        b_end = func_matches[idx_f + 1].start() if idx_f + 1 < len(func_matches) else n
        if fname in BLOCKED_FUNCS_V3:
            blocked_func_ranges.append((fm.start(), b_end))
        # Find closing ')' of func header
        p_open = fm.end() - 1
        d = 1
        p = p_open + 1
        while p < n and d > 0:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if in_code[p]:
                if src[p] == "(":
                    d += 1
                elif src[p] == ")":
                    d -= 1
                    if d == 0:
                        func_sig_ranges.append((p_open, p + 1))
                        break
            p += 1

    def in_ranges(pos: int, ranges: list) -> bool:
        for s0, e0 in ranges:
            if s0 <= pos < e0:
                return True
        return False

    def skip_ws(p: int) -> int:
        while p < n:
            if src[p] in " \t\r\n":
                p += 1
            elif src[p] == "#":
                nl = src.find("\n", p)
                p = n if nl == -1 else nl + 1
            else:
                break
        return p

    def prev_non_ws(p: int) -> int:
        p -= 1
        while p >= 0 and src[p] in " \t\r\n":
            p -= 1
        return p

    def find_matching_close(open_pos: int, open_ch: str, close_ch: str) -> int:
        p = open_pos + 1
        d = 1
        while p < n and d > 0:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if in_code[p]:
                if src[p] == open_ch:
                    d += 1
                elif src[p] == close_ch:
                    d -= 1
                    if d == 0:
                        return p
            p += 1
        return n - 1

    def extract_call_args_ranges(open_p: int) -> list[tuple[int, int]]:
        args = []
        p = open_p + 1
        arg_s = p
        d = 1
        while p < n and d > 0:
            if p in str_literals:
                p = str_literals[p][2] + 1
                continue
            if in_code[p]:
                c = src[p]
                if c in "([{":
                    d += 1
                elif c in ")]}":
                    d -= 1
                    if d == 0:
                        args.append((arg_s, p))
                        break
                elif c == "," and d == 1:
                    args.append((arg_s, p))
                    arg_s = p + 1
            p += 1
        return args

    # Build blocked call char spans!
    blocked_call_ranges = []
    set_flag_allowed_ranges = []
    call_re = re.compile(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*\(")
    for m in call_re.finditer(src):
        if not in_code[m.start()]:
            continue
        cname = m.group(1)
        open_p = m.end() - 1
        # Check for Log.print / Console.addCommand etc.
        pre = src[max(0, m.start() - 10) : m.start()]
        if cname in BLOCKED_CALLS_V3 or pre.endswith(("Log.", "Console.")):
            close_p = find_matching_close(open_p, "(", ")")
            blocked_call_ranges.append((m.start(), close_p + 1))
        elif cname in ("setFlag", "setModuleFlag"):
            close_p = find_matching_close(open_p, "(", ")")
            blocked_call_ranges.append((m.start(), close_p + 1))
            args = extract_call_args_ranges(open_p)
            # For setFlag(flagID, val) -> arg 1; for setModuleFlag(modID, flagID, val) -> arg 2
            val_idx = 1 if cname == "setFlag" else 2
            if val_idx < len(args):
                rs, re_p = args[val_idx]
                set_flag_allowed_ranges.append((rs, re_p))

    norm_rel = rel_path.replace("\\", "/")
    is_global_registry = norm_rel == "GlobalRegistry.gd"

    def is_unsafe(q_pos: int, close_q: int, raw: str) -> bool:
        if in_ranges(q_pos, blocked_func_ranges) or in_ranges(q_pos, func_sig_ranges):
            return True
        if is_global_registry:
            # Skip module-level `var x = "..."` declarations in GlobalRegistry.gd
            line_s = src.rfind("\n", 0, q_pos) + 1
            if re.match(r"^(?:var|const)\s+", src[line_s:q_pos]):
                return True
        if in_ranges(q_pos, blocked_call_ranges):
            # Only allow if inside the final value arg of setFlag/setModuleFlag AND >=3 words w/o dots
            if in_ranges(q_pos, set_flag_allowed_ranges):
                words = re.findall(r"\b[A-Za-z]{2,}\b", raw)
                if len(words) >= 3 and "." not in raw and "_" not in raw:
                    return False
            return True

        # Check line context: # comments, const declarations, ID/scene/path assignments
        line_s = src.rfind("\n", 0, q_pos) + 1
        line_pre = src[line_s:q_pos].lstrip()
        if line_pre.startswith("#"):
            return True
        if re.match(r"^const\s+[A-Za-z0-9_]+\s*(?::\s*[A-Za-z0-9_]+\s*)?=$", line_pre.strip()):
            return True
        if re.match(
            r"^(?:var\s+)?(?:[A-Za-z0-9_]+\.)?(?:id|ID|scene|roomID|charID|flagID|moduleID|talkScene|nextStoryScene|[a-z0-9_]+(?:ID|Id|Scene|Path|Animation|Anim|Tag|Flag))\s*(?::\s*[A-Za-z0-9_]+\s*)?\+?=$",
            line_pre.strip(),
        ):
            return True

        pb = prev_non_ws(q_pos)
        na = skip_ws(close_q + 1)

        # Dict key `"key": val`
        if na < n and src[na] == ":":
            return True
        # Subscript `obj["key"]` (distinguish from list literals after keywords like `return [...]` or `in [...]`)
        if pb >= 0 and src[pb] == "[":
            pb2 = prev_non_ws(pb)
            if pb2 >= 0 and (src[pb2].isalnum() or src[pb2] in "_)]"):
                # Extract identifier before '[' if alphanumeric
                w_end = pb2 + 1
                w_start = pb2
                while w_start > 0 and (src[w_start - 1].isalnum() or src[w_start - 1] == "_"):
                    w_start -= 1
                prev_word = src[w_start:w_end]
                if prev_word not in ("return", "in", "not", "and", "or", "if", "elif", "else", "await", "yield"):
                    return True
        # Comparison == or !=
        if pb >= 1 and src[pb - 1 : pb + 1] in ("==", "!="):
            return True
        if na + 1 < n and src[na : na + 2] in ("==", "!="):
            return True
        # `in [...]`
        if pb >= 0 and src[pb] in "[,":
            scan = q_pos - 1
            d = 0
            while scan >= max(0, q_pos - 250):
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
                        if re.search(r"\bin\s*$", src[max(0, scan - 12) : scan]):
                            return True
                        break
                    d -= 1
                scan -= 1
        return False

    spans = []
    for q_pos in sorted(str_literals):
        s, e, close_q = str_literals[q_pos]
        raw = src[s:e]
        if is_unsafe(q_pos, close_q, raw):
            continue
        if is_prose_v3(raw, norm_rel):
            spans.append((s, e, raw))
    return spans


def should_skip_file(rel: str) -> bool:
    norm = rel.replace("\\", "/")
    if norm in SKIP_FILE_EXACT or norm.startswith(SKIP_DIR_PREFIXES) or norm.startswith(SKIP_FILE_PREFIXES):
        return True
    return False


def build_queue_v3(done_set: set[str]) -> list[str]:
    items = []
    for dp, dn, fns in os.walk(REPO_ROOT):
        for skip in (".git", "ru_tools", "build", ".import", "AssetsSource", "addons"):
            if skip in dn:
                dn.remove(skip)
        for fn in fns:
            if not fn.endswith(".gd"):
                continue
            rel = os.path.relpath(os.path.join(dp, fn), REPO_ROOT).replace("\\", "/")
            if rel in done_set or should_skip_file(rel):
                continue
            items.append(rel)

    def prio(rel: str):
        for pfx, rank in PRIORITY_ORDER:
            if rel.startswith(pfx):
                return (rank, rel)
        return (9, rel)

    items.sort(key=prio)
    return items


def process_gd_v3(rel_path: str, tm: dict, dry_run: bool = False) -> tuple[bool, list[str]]:
    fp = os.path.join(REPO_ROOT, rel_path)
    src = open(fp, "r", encoding="utf-8", errors="replace").read()
    spans = scan_gd_v3_spans(src, rel_path)
    if not spans:
        return False, []
    texts = [t for _, _, t in spans]
    if dry_run:
        return True, texts
    # Protect stray leading ']' from split BBCode like "[color=...]Text[/color]"
    prefixes = []
    cores = []
    for t in texts:
        m_pre = re.match(r"^(\]+(?:\s+)?)", t)
        if m_pre and not t.startswith("[["):
            prefixes.append(m_pre.group(1))
            cores.append(t[len(m_pre.group(1)) :])
        else:
            prefixes.append("")
            cores.append(t)
    translated_cores = translate_batch(cores, tm, f"BDCC GDScript Pass 3: {rel_path}")
    translated = [p + c for p, c in zip(prefixes, translated_cores)]
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
        with open(fp, "w", encoding="utf-8", newline="") as f:
            f.write("".join(out))
    return changed, texts


def run_dry_run(exclude_v2_left: bool = True):
    v2_left = set()
    if exclude_v2_left and os.path.exists(QUEUE_FILE_V2):
        v2_left = set(p.replace("\\", "/") for p in load_json(QUEUE_FILE_V2, []))
    queue = build_queue_v3(set())
    total_strings = 0
    files_with_work = 0
    samples = {}
    sample_buckets = (
        "UI/ButtonChecks.gd",
        "Attacks/",
        "Inventory/Items/",
        "Skills/Perk/",
        "Characters/Character.gd",
        "Characters/Dynamic/",
        "Player/Bodyparts/",
        "Game/MainScene.gd",
        "Game/DomRoute/",
        "Game/SlaveAuction/",
        "Scenes/",
        "Modules/",
    )
    for rel in queue:
        if exclude_v2_left and rel in v2_left:
            continue
        ch, texts = process_gd_v3(rel, {}, dry_run=True)
        if ch and texts:
            files_with_work += 1
            total_strings += len(texts)
            for b in sample_buckets:
                if rel.startswith(b) and b not in samples:
                    samples[b] = (rel, texts[:8])
                    break

    scope_note = " (already-done by Pass 2)" if exclude_v2_left else " (full repo)"
    print(f"V3_DRY_RUN_FILES_WITH_WORK{scope_note}: {files_with_work} files")
    print(f"V3_DRY_RUN_TOTAL_STRINGS{scope_note}: {total_strings:,}")
    for b in sample_buckets:
        if b in samples:
            rel, ts = samples[b]
            print(f"\n--- BUCKET {b} -> {rel} ---")
            for t in ts:
                print(" ", repr(t[:120]))


def main():
    if "--dry-run" in sys.argv:
        run_dry_run(exclude_v2_left="--all" not in sys.argv)
        return

    os.makedirs(TOOLS_DIR, exist_ok=True)
    prog = load_json(PROGRESS_FILE_V3, {"done": []})
    done_set = set(prog.get("done", []))
    tm = load_json(CACHE_FILE, {})
    if "--rebuild-queue" in sys.argv or not os.path.exists(QUEUE_FILE_V3):
        queue = build_queue_v3(done_set)
        save_json_atomic(QUEUE_FILE_V3, queue)
    else:
        queue = load_json(QUEUE_FILE_V3, [])

    print(f"[BDCC_V3] Queue={len(queue)}, Done={len(done_set)}, TM={len(tm)}", flush=True)
    processed_since_save = 0

    while queue:
        rel = queue[0]
        t0 = time.monotonic()
        try:
            ch, _ = process_gd_v3(rel, tm, dry_run=False)
            dt = time.monotonic() - t0
            queue.pop(0)
            done_set.add(rel)
            prog["done"] = sorted(done_set)
            processed_since_save += 1
            if ch or processed_since_save % 25 == 0 or not queue:
                save_json_atomic(PROGRESS_FILE_V3, prog)
                save_json_atomic(QUEUE_FILE_V3, queue)
                save_json_atomic(CACHE_FILE, tm)
            if ch or len(queue) % 50 == 0 or not queue:
                hs, _, _ = get_nvapi_hotspot_temp()
                print(
                    f"[BDCC_V3] ({len(queue)} left | {len(done_set)} done) {rel} ({dt:.1f}s, ch={ch}) | TM={len(tm)} | HotSpot={hs:.1f}C",
                    flush=True,
                )
        except Exception as ex:
            print(f"  ERR {rel}: {ex}", flush=True)
            queue.pop(0)


if __name__ == "__main__":
    main()
