#!/usr/bin/env python3
"""
Autonomous batch translator for BDCC (Godot 3.6.2 GDScript + .tscn)
using local Gemma 4 26B A4B + NVAPI HotSpot thermal guard.
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
QUEUE_FILE = os.path.join(TOOLS_DIR, "queue_bdcc.json")
PROGRESS_FILE = os.path.join(TOOLS_DIR, "progress_bdcc.json")
API_URL = "http://127.0.0.1:8080/v1/chat/completions"
MODEL = "gemma-4-26b-abliterated"

BRACE_RE = re.compile(r"\{[^{}\n]+\}")
BBCODE_RE = re.compile(r"\[[^\[\]\n]+\]")
FMT_RE = re.compile(r"(?:\\n|\\t|\\\"|%(?:\.\d+)?[sdf]|\\u[0-9a-fA-F]{4})")
MASK_ANY_RE = re.compile(r"@@[BTF]\d+@@")

SAY_CALL_RE = re.compile(r"\b(?:saynn|sayn|say|sayLine)\s*\(")
BTN_CALL_RE = re.compile(r"\b(?:addButton|addDisabledButton|addButtonWithChecks)\s*\(")
PROP_ASSIGN_RE = re.compile(
    r'^\s*(?:var\s+)?(?:text|visibleName|name|description|tooltip|hint_tooltip|title|label|subtitle|header)\s*(?::\s*String\s*)?=\s*"((?:[^"\\]|\\.)*)"',
    re.M,
)
TEXT_FUNC_RE = re.compile(
    r"^\s*func\s+(?:getVisibleName|getDescription|getTooltip|getName|getShortName|getTitle|getText|getAttackName|getMessage|getCategoryName|getBuffDescription|getDetails)\s*\(",
    re.M,
)
TSCN_PROP_RE = re.compile(
    r'^(\s*(?:text|placeholder_text|hint_tooltip|window_title|dialog_text)\s*=\s*)"((?:[^"\\]|\\.)*)"(\s*)$',
    re.M,
)

PRIORITY_DIRS = [
    "UI/MainMenu",
    "UI/LaunchScreen",
    "UI/",
    "Game/UI/",
    "Game/PlayerPanel",
    "Scenes/",
    "Events/",
    "Game/",
    "Quests/",
    "Modules/",
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


def has_translatable_en(s: str) -> bool:
    if not s or len(s.strip()) < 2:
        return False
    low = s.strip()
    if low.startswith(("res://", "user://", "http://", "https://")):
        return False
    if re.fullmatch(r"[A-Za-z0-9_./:-]+", low) and " " not in low:
        if not (low[0].isupper() and len(low) >= 3 and any(c.islower() for c in low)):
            return False
    cleaned = BRACE_RE.sub(" ", low)
    cleaned = BBCODE_RE.sub(" ", cleaned)
    cleaned = FMT_RE.sub(" ", cleaned)
    return bool(re.search(r"[A-Za-z]{2,}", cleaned))


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

    masked = BRACE_RE.sub(repl("B"), text)
    masked = BBCODE_RE.sub(repl("T"), masked)
    masked = FMT_RE.sub(repl("F"), masked)
    return masked, masks


def unmask_str(text: str, masks: dict) -> str:
    for k, v in masks.items():
        text = text.replace(k, v)
    return text


def validate_masks(translated: str, masks: dict) -> bool:
    if "Контекст:" in translated or "Context:" in translated:
        return False
    found = MASK_ANY_RE.findall(translated)
    if any(tok not in masks for tok in found):
        return False
    return all(k in translated for k in masks)


def call_llm(messages: list, json_mode: bool = False, max_tokens: int = 3072) -> str:
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


def translate_single(text: str, context_note: str) -> str:
    masked, masks = mask_str(text)
    if not has_translatable_en(MASK_ANY_RE.sub(" ", masked)):
        return text
    sys_p = (
        "You are an expert Russian literary translator for the explicit 18+ sci-fi RPG 'Broken Dreams Correctional Center (BDCC)'. "
        "Translate into natural, idiomatic, uncensored Russian. "
        "CRITICAL: Keep EVERY @@B*@@, @@T*@@, @@F*@@ token EXACTLY as written, without adding or removing any @@...@@ tokens. "
        "Output ONLY the Russian translation without quotes or notes."
    )
    usr_p = f"Context: {context_note}\nText:\n{masked}"
    for _ in range(3):
        try:
            out = call_llm([{"role": "system", "content": sys_p}, {"role": "user", "content": usr_p}], False, 2048)
            if validate_masks(out, masks):
                return unmask_str(out, masks)
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
            if not has_translatable_en(s):
                idx += 1
                continue
            if s in tm:
                results[idx] = tm[s]
                idx += 1
                continue
            if batch_indices and char_sum + len(s) > 1500:
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
        for pos, orig_i in enumerate(batch_indices):
            m_txt, m_dict = mask_str(items[orig_i])
            masked_map[str(pos)] = m_txt
            masks_map[str(pos)] = m_dict

        sys_p = (
            "You are an expert Russian literary translator for the explicit 18+ sci-fi RPG 'Broken Dreams Correctional Center (BDCC)'. "
            "Translate every string in the JSON object into natural, idiomatic, uncensored Russian. "
            "Return ONLY a JSON object with the exact same numeric string keys. "
            "CRITICAL: Keep EVERY @@B*@@, @@T*@@, @@F*@@ token EXACTLY intact, never add or remove @@...@@ tokens."
        )
        usr_p = f"Context: {context_note}\nJSON:\n{json.dumps(masked_map, ensure_ascii=False)}"
        ok = False
        for _ in range(2):
            try:
                raw = call_llm([{"role": "system", "content": sys_p}, {"role": "user", "content": usr_p}], True, 3072)
                parsed = json.loads(raw)
                if isinstance(parsed, dict) and all(str(p) in parsed for p in range(len(batch_indices))):
                    all_good = True
                    for pos, orig_i in enumerate(batch_indices):
                        val = str(parsed[str(pos)])
                        if not validate_masks(val, masks_map[str(pos)]):
                            all_good = False
                            break
                        unm = unmask_str(val, masks_map[str(pos)])
                        results[orig_i] = unm
                        if unm != items[orig_i]:
                            tm[items[orig_i]] = unm
                    if all_good:
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
    # Escape unescaped double quotes and literal newlines for single-line GDScript "..."
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


def find_string_spans_in_gd(src: str) -> list[tuple[int, int, str]]:
    """Return non-overlapping (start, end, inner_text) spans safe to translate in GDScript."""
    spans = []
    n = len(src)

    def skip_ws_and_comments(pos: int) -> int:
        while pos < n:
            if src[pos] in " \t\r\n":
                pos += 1
            elif src[pos] == "#":
                nl = src.find("\n", pos)
                pos = n if nl == -1 else nl + 1
            else:
                break
        return pos

    def read_str_literal(pos: int):
        if pos >= n or src[pos] != '"':
            return None
        if src.startswith('"""', pos):
            return None  # handle triple quotes separately if needed
        i = pos + 1
        while i < n:
            if src[i] == "\\":
                i += 2
            elif src[i] == '"':
                return (pos + 1, i, src[pos + 1 : i])
            elif src[i] == "\n":
                return None
            else:
                i += 1
        return None

    def extract_call_args(open_paren_pos: int, max_str_args: int):
        i = open_paren_pos + 1
        arg_idx = 0
        depth = 1
        while i < n and depth > 0:
            i = skip_ws_and_comments(i)
            if i >= n:
                break
            if depth == 1 and arg_idx < max_str_args and src[i] == '"':
                lit = read_str_literal(i)
                if lit:
                    spans.append(lit)
                    i = lit[1] + 1
                    continue
            if src[i] == '"':
                lit = read_str_literal(i)
                if lit:
                    i = lit[1] + 1
                    continue
            if src[i] in "([{":
                depth += 1
            elif src[i] in ")]}":
                depth -= 1
                if depth == 0:
                    break
            elif src[i] == "," and depth == 1:
                arg_idx += 1
            i += 1

    for m in SAY_CALL_RE.finditer(src):
        extract_call_args(m.end() - 1, 1)
    for m in BTN_CALL_RE.finditer(src):
        extract_call_args(m.end() - 1, 2)
    for m in PROP_ASSIGN_RE.finditer(src):
        spans.append((m.start(1), m.end(1), m.group(1)))

    # return "..." inside known text-returning methods
    for fm in TEXT_FUNC_RE.finditer(src):
        block_start = fm.end()
        next_func = re.search(r"^\s*func\s+", src[block_start:], re.M)
        block_end = block_start + next_func.start() if next_func else n
        block = src[block_start:block_end]
        for rm in re.finditer(r'\breturn\s+"((?:[^"\\]|\\.)*)"', block):
            s0 = block_start + rm.start(1)
            e0 = block_start + rm.end(1)
            spans.append((s0, e0, rm.group(1)))

    # Deduplicate and sort
    unique = {}
    for s, e, txt in spans:
        if has_translatable_en(txt):
            unique[(s, e)] = txt
    ordered = sorted((s, e, t) for (s, e), t in unique.items())
    # Filter overlaps
    clean = []
    last_e = -1
    for s, e, t in ordered:
        if s >= last_e:
            clean.append((s, e, t))
            last_e = e
    return clean


def process_gd_file(rel_path: str, tm: dict) -> bool:
    fp = os.path.join(REPO_ROOT, rel_path)
    src = open(fp, "r", encoding="utf-8", errors="replace").read()
    spans = find_string_spans_in_gd(src)
    if not spans:
        return False
    texts = [t for _, _, t in spans]
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
        with open(fp, "w", encoding="utf-8") as f:
            f.write("".join(out))
    return changed


def process_tscn_file(rel_path: str, tm: dict) -> bool:
    fp = os.path.join(REPO_ROOT, rel_path)
    src = open(fp, "r", encoding="utf-8", errors="replace").read()
    matches = [m for m in TSCN_PROP_RE.finditer(src) if has_translatable_en(m.group(2))]
    if not matches:
        return False
    texts = [m.group(2) for m in matches]
    translated = translate_batch(texts, tm, f"BDCC UI Scene: {rel_path}")
    out = []
    pos = 0
    changed = False
    for m, tr in zip(matches, translated):
        out.append(src[pos : m.start(2)])
        if tr != m.group(2):
            out.append(sanitize_gd_literal(tr, m.group(2)))
            changed = True
        else:
            out.append(m.group(2))
        pos = m.end(2)
    out.append(src[pos:])
    if changed:
        with open(fp, "w", encoding="utf-8") as f:
            f.write("".join(out))
    return changed


def build_queue(done_set: set[str]) -> list[str]:
    items = []
    for dp, dn, fns in os.walk(REPO_ROOT):
        for skip in (".git", "ru_tools", "build", ".import"):
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
        for idx, p in enumerate(PRIORITY_DIRS):
            if rel.startswith(p):
                return (0 if rel.endswith(".tscn") else 1, idx, rel)
        return (0 if rel.endswith(".tscn") else 1, len(PRIORITY_DIRS), rel)

    items.sort(key=prio)
    return items


def main():
    os.makedirs(TOOLS_DIR, exist_ok=True)
    prog = load_json(PROGRESS_FILE, {"done": []})
    done_set = set(prog.get("done", []))
    tm = load_json(CACHE_FILE, {})
    if "--rebuild-queue" in sys.argv or not os.path.exists(QUEUE_FILE):
        queue = build_queue(done_set)
        save_json_atomic(QUEUE_FILE, queue)
    else:
        queue = load_json(QUEUE_FILE, [])

    print(f"[BDCC] Queue={len(queue)}, Done={len(done_set)}, TM={len(tm)}", flush=True)
    t_start = time.monotonic()
    processed_since_save = 0

    while queue:
        rel = queue[0]
        t0 = time.monotonic()
        try:
            if rel.endswith(".tscn"):
                ch = process_tscn_file(rel, tm)
            else:
                ch = process_gd_file(rel, tm)
            dt = time.monotonic() - t0
            queue.pop(0)
            done_set.add(rel)
            prog["done"] = sorted(done_set)
            processed_since_save += 1
            if ch or processed_since_save % 25 == 0 or not queue:
                save_json_atomic(PROGRESS_FILE, prog)
                save_json_atomic(QUEUE_FILE, queue)
                save_json_atomic(CACHE_FILE, tm)
            if ch or len(queue) % 50 == 0:
                hs, core, vram = get_nvapi_hotspot_temp()
                print(
                    f"[BDCC] ({len(queue)} left | {len(done_set)} done) {rel} ({dt:.1f}s, ch={ch}) | TM={len(tm)} | HotSpot={hs:.1f}C",
                    flush=True,
                )
        except Exception as ex:
            print(f"  ERR {rel}: {ex}", flush=True)
            queue.pop(0)
            save_json_atomic(QUEUE_FILE, queue)

    print(f"[BDCC] ALL DONE in {time.monotonic() - t_start:.1f}s! Done={len(done_set)}, TM={len(tm)}", flush=True)


if __name__ == "__main__":
    main()
