# nex_uipack

Redesigned UI pack for `ox_lib`. Owns the NUI iframe and bridges Lua ↔ UI traffic through `ox_lib`.

## ⚠️ Required Dependency — Forked `ox_lib`

This resource **will not work with the upstream `ox_lib`**. You must install the NEX Development fork, which exposes the hooks this UI pack needs:

**➡️ https://github.com/nexdevelopmentx/ox_lib**

### Install

1. Remove (or rename) your existing `ox_lib` resource.
2. Download the fork from the repo above:
   - Grab the latest release ZIP, **or**
   - `git clone https://github.com/nexdevelopmentx/ox_lib` into your resources folder.
3. Make sure the resource folder is named `ox_lib` (not `ox_lib-main`).
4. Start `ox_lib` **before** `nex_uipack` in your `server.cfg`:

   ```cfg
   ensure ox_lib
   ensure nex_uipack
   ```

5. Restart the server.

## Languages

All text the UI draws on its own is translated from JSON files in `locales/`. English (`en.json`) and Spanish (`es.json`) ship with the pack. That covers dialog buttons (Cancel / Confirm / Clear), the select/search field text, the progress bar ("In progress", "… remaining", "Press to cancel"), the skill check (title, key prompt, difficulty labels), and the default notification titles (Error / Success / Warning / Notification).

Text that comes from a script call — notification bodies, menu titles, field labels, etc. — is passed in by whatever resource calls `ox_lib`, so it is not part of these files.

Pick the active language in `lua/config.lua`:

```lua
locale = 'en', -- 'en' | 'es' | your own code
```

Add your own language:

1. Copy `locales/en.json` to `locales/<code>.json` (e.g. `de.json`).
2. Translate the values (keep the keys as-is). Leave the `{key}` / `{time}` placeholders in place — they get replaced at runtime.
3. Set `locale = '<code>'` in `lua/config.lua`.
4. Restart the resource (`ensure nex_uipack`).

Locale files are plain JSON and stay editable — they are **not** part of the escrowed bundle. An unknown or broken file falls back to English, as does any individual key a translation leaves out.

## Notes

- If you already have scripts that depend on upstream `ox_lib`, the fork is a drop-in replacement — it adds functionality without breaking the existing API.
- Keep the forked `ox_lib` updated alongside `nex_uipack` releases.
