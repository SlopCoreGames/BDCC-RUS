<div align="center">

# Broken Dreams Correctional Center (BDCC) — Русская локализация (RU)

**Неофициальный проект полной русской локализации научно-фантастической RPG *BDCC* с открытым исходным кодом**

[![Origin](https://img.shields.io/badge/Оригинал-Alexofp%2FBDCC-purple?style=flat-square)](https://github.com/Alexofp/BDCC)
[![Engine](https://img.shields.io/badge/Движок-Godot%203.6.2%20(GDScript)-blue?style=flat-square)](#скачать-и-запустить)
[![LLM](https://img.shields.io/badge/Перевод-Gemma%204%2026B%20A4B%20(Local)-green?style=flat-square)](#как-устроен-пайплайн-перевода)
[![Status](https://img.shields.io/badge/Статус-Готово%20100%25%20(v0.4.1)-brightgreen?style=flat-square)](#статус-локализации)
[![Release](https://img.shields.io/badge/Скачать-Release%20v1.1-orange?style=flat-square)](https://github.com/SlopCoreGames/BDCC-RUS/releases/latest)

</div>

---

> [!WARNING]
> **18+ / NSFW:** *Broken Dreams Correctional Center (BDCC)* — взрослая текстовая RPG на движке Godot. Все права на оригинальную игру, сюжет и ассеты принадлежат автору **Alexofp (Rahi)**.

---

## Скачать и запустить

Все сборки доступны на странице **[Release v1.1](https://github.com/SlopCoreGames/BDCC-RUS/releases/latest)**:

| Платформа | Файл | Размер | Как запустить |
| --- | --- | --- | --- |
| **Windows 64-bit** | `BDCC_RU_v0.4.1_Win64.zip` | `66.0 МБ` | Распакуйте в одну папку (`BDCC.exe` + `BDCC.pck`) и запустите `BDCC.exe` |
| **Android (APK)** | `BDCC_RU_v0.4.1_Android.apk` | `115.0 МБ` | ARM64 + ARMv7, подпись APK v1/v2/v3 (перед установкой поверх EN-версии удалите оригинал) |
| **Web / HTML5** | `BDCC_RU_v0.4.1_Web.zip` | `58.3 МБ` | Распакуйте и запустите `start_web_server.bat` или `python3 -m http.server 8060` |
| **Linux 64-bit** | `BDCC_RU_v0.4.1_Linux64.zip` | `66.6 МБ` | Распакуйте в одну папку, права `+x` уже выставлены; запуск `./BDCC.x86_64` |
| **macOS** | `BDCC_RU_v0.4.1_macOS.zip` | `75.5 МБ` | Неподписанный `.app`-бандл (`xattr -cr BDCC.app` при срабатывании Gatekeeper) |

> [!TIP]
> **Portable-режим (Windows / Linux):** создайте пустую папку `BDCCData` рядом с исполняемым файлом до запуска, чтобы хранить сохранения, настройки и моды прямо в ней.
> **Web (HTML5):** браузеры блокируют WebAssembly по `file://`, поэтому игру нужно открывать через локальный HTTP-сервер (`http://localhost:8060`).

---

## Статус локализации

| Компонент / Проверка | Результат |
| --- | --- |
| **Базовая версия игры** | BDCC `0.4.1` (форк [`Alexofp/BDCC`](https://github.com/Alexofp/BDCC)) |
| **Покрытие файлов (Pass 1 + 2 + 3 + SlaveAuction)** | **`2 842` `.gd` и `335` `.tscn`** переведены относительно апстрима (`4 021/4 021` пройдено в Pass 2, дожимной Pass 3 + `SlaveAuction`: помещения `.tscn`, HUD, перки, `ButtonChecks`, `ModularDialogue`, `SexEngine`, `SlaveAuction`, атаки, боевые предметы) |
| **Память переводов (`tm_cache_bdcc.json`)** | **`96 057`** очищенных записей |
| **Кириллические шрифты** | `Carlito` (`Regular / Bold / Italic / BoldItalic`) в UI + кириллический fallback для `BodyWritingsFont` |
| **Статический аудит** | `0` утечек масок `@@`, `0` ошибок `{...}` / `[say=...]` / `printf` / Unicode, `0` кириллицы в ID и опкодах `CrotchCode` |
| **Автотест Godot 3.6.2 (`VerifyBDCC.tscn`)** | `VERIFY_PASS`: `3369/3369` `.gd`, `652/652` `.tscn`, `GlobalRegistry` (`679` сцен, `136` предметов, `105` персонажей, `91` атака, `9` видов) |
| **Живой запуск `BDCC.exe`** | Проверен в изолированном portable-режиме (`Using portable save directory`, `GlobalRegistry fully initialized in: 16.0s`, `0` ошибок) |
| **Кросс-платформенные сборки** | `apksigner verify` v1/v2/v3 + `zipalign` для `.apk`; HTTP `200 OK` для Web; ELF `+x` для Linux; `.app`-бандл для macOS |

---

## О проекте

Этот репозиторий — форк [`Alexofp/BDCC`](https://github.com/Alexofp/BDCC) с полной русской локализацией:
- **Кириллический шрифт из коробки:** стандартный шрифт `Titillium` не содержит русской кириллицы, поэтому в UI и диалоговых ресурсах подключён пропорциональный шрифт **Carlito** (`Regular / Bold / Italic / BoldItalic`), а для `BodyWritingsFont` настроен кириллический fallback.
- **Перевод всех сцен, событий, модулей и интерфейса:** переведены диалоговые скрипты (`.gd`), текстовые поля интерфейса (`.tscn`), кнопки и тултипы с сохранением всех идентификаторов сцен, флагов и подстановок.

---

## Как устроен пайплайн перевода

Инструменты автоматизации лежат в [`ru_tools/`](ru_tools/):

1. **Контекстный парсер GDScript и `.tscn`:**
   - Переводятся строго пользовательские строки (`saynn`, `sayn`, `say`, заголовки и описания в `addButton` / `addDisabledButton`, UI-свойства `.tscn`, описания предметов/перков/квестов).
   - Системные идентификаторы сцен, флагов модулей (`getModuleFlag` / `setFlag`), путей (`res://`), имён персонажей и ID кнопок остаются нетронутыми.
2. **Двойная защита синтаксиса:**
   - Фигурные подстановки (`{pc.name}`, `{npc.he}`), BBCode-теги (`[b]`, `[say=...]`, `[color=...]`), форматные спецификаторы (`%s`, `\n`) маскируются в `@@...@@` со строгой проверкой отсутствия утечек.
3. **Высокая эффективность и отсутствие простоя GPU:**
   - Локальная модель **`Gemma-4-26B-A4B-It-Abliterated (Q5_K_M)`** на `llama.cpp` загружена на 100% в VRAM RTX 3090 (`-ngl 99`), без выгрузки слоёв в медленную ОЗУ.
   - Батчинг по `8–12` строк + локальный кэш `tm_cache_bdcc.json` + непрерывная очередь `queue_bdcc.json` без пауз ожидания + термозащита по реальному GPU HotSpot через NVAPI (`98°C -> 86°C`).

---

## Сборка из исходников

Для сборки требуется **Godot Engine 3.6.2 (Standard)** и официальные Export Templates `3.6.2.stable`:

```bash
# Windows (.exe + .pck)
godot -v --export "Windows Desktop" ./build/windows/BDCC.exe

# Android (.apk)
godot -v --export "Android" ./build/android/BDCC.apk
```

---

## Благодарности

- **[Alexofp (Rahi)](https://github.com/Alexofp)** — автору *Broken Dreams Correctional Center* за масштабную open-source RPG на Godot и открытую архитектуру модулей ([`Alexofp/BDCC`](https://github.com/Alexofp/BDCC)).
- **Команде Godot Engine** — за свободный движок с простым кроссплатформенным экспортом.
- **Команде `llama.cpp` и сообществу открытых LLM** — за быстрый локальный инференс без цензуры.
- **Авторам шрифта Carlito** — за качественную кириллицу.
