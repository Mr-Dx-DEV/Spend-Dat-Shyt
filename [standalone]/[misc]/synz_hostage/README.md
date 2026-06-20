# Synz Labs v2.0

Showcase: https://www.youtube.com/watch?v=0lYizf3DAxE
Store: https://synzlabs.com/
Documentation: https://synzlabs.com/docs/hostage-npc

Advanced NPC Hostage & Robbery System for FiveM.

---

## What's New in v2.0

### Framework & Compatibility
- **Auto-detect framework** — Set `Config.Framework = 'auto'` and it will detect QBCore, QBox (QBX), or ESX automatically
- **ox_lib full integration** — Notifications, progress bars, skillchecks, textUI
- **Bridge architecture** — All framework-specific code isolated in `bridge/` for easy customization
- **Multi-inventory support** — Auto-detects ox_inventory, qs-inventory, qb-inventory, lj-inventory, codem-inventory

### New Features
- **Skillcheck system** (ox_lib) — Optional skillcheck before looting
- **Global robbery cooldown** — Prevents spam-robbing multiple NPCs
- **NPC resist notification** — Players get notified when NPC fights back
- **Expanded weapon list** — 20+ weapons now supported
- **Emergency-dispatch** support added to dispatch bridge
- **ox_lib textUI** — Used for hostage controls and loot interaction when available
- **QBox (QBX) support** — Works with the QBox fork out of the box
- **Standalone mode** — Basic functionality even without a framework

### Bug Fixes
- **Fixed duplicate `pickupAnim` event registration** — Was registered twice in original
- **Fixed `os.clock()` for anti-spam** — Replaced with `os.time()` which is more reliable
- **Fixed dispatch systems** — qs-dispatch and ps-dispatch now use proper export signatures
- **Fixed ESX player iteration** — Now handles both `GetExtendedPlayers` and `GetPlayers` fallback
- **Fixed notification formatting** — Removed hardcoded GTA text formatting (`~r~`, `~g~`) in favor of clean text (works better with ox_lib/okokNotify)
- **Fixed anim dict loading** — Added timeout to prevent infinite loops if dict doesn't exist
- **Fixed model loading** — Same timeout protection
- **Fixed event names** — All events now use `synz_hostage:` prefix consistently
- **Fixed hostage cleanup** — Properly hides textUI on resource stop
- **Removed escrow dependency** — No more `dependency '/assetpacks'`

### UI Redesign
- Change of theme
- Smooth entry animations
- Numbered options with active marker
- Minimal footprint — doesn't obstruct gameplay

---

## Requirements

**Framework (one of):**
- QBCore / QBox (`qb-core` or `qbx_core`)
- ESX (`es_extended`)
- Standalone (limited features)

**Optional:**
- `ox_lib` — Notifications, progress, skillcheck, textUI
- `ox_target` / `qb-target` — Loot pickup interaction
- `ox_inventory` / `qs-inventory` / `qb-inventory` — Item management
- Any supported dispatch system

---

## Installation

1. Place `synz_hostage` in your resources folder
2. Add to `server.cfg`:
```cfg
ensure ox_lib          # optional but recommended
ensure qb-core         # or es_extended
ensure ox_target       # or qb-target (optional)
ensure synz_hostage
```
3. Edit `config.lua` to your liking
4. Restart server

---

## Config Quick Reference

| Setting | Default | Description |
|---------|---------|-------------|
| `Config.Framework` | `'auto'` | Auto-detect or force `'QBCORE'` / `'ESX'` |
| `Config.Notifications` | `'auto'` | `'auto'` / `'ox_lib'` / `'okokNotify'` / `'native'` |
| `Config.TargetMode` | `'auto'` | `'auto'` / `'ox'` / `'qb'` / `'none'` |
| `Config.Skillcheck.Enabled` | `false` | Requires ox_lib |
| `Config.ResistChance` | `0.15` | 0.0 - 1.0 |
| `Config.MinPolice` | `0` | Minimum cops online |
| `Config.GlobalCooldownMs` | `30000` | Anti-spam between robberies |

---

## Credits

- **Original:** Synz Labs
- **v2.0 Rewrite:** Enhanced with bridge architecture, ox_lib support, UI redesign, bug fixes
