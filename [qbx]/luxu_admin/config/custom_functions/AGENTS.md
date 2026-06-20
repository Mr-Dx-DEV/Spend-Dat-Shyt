# AGENTS.md - Custom Functions

Practical guidance for contributors and AI agents working in `config/custom_functions/`.

This folder is the supported extension point for Luxu Admin. Use it to add custom addon buttons, quick actions, quick toggles, statistic blocks, and map zone handlers without editing core modules.

## Folder Purpose

Files in this directory:

- `client.lua`: client-side registrations and handlers (addons, statistics declaration, zone handlers)
- `server.lua`: server-side callbacks (addon buttons + statistic block providers)
- `types.lua`: type definitions and signatures (`Addon`, `Zone`, `ZoneHandlerReturn`, registration APIs)

Runtime loading:

- `client.lua` is loaded from `client/cl_main.lua`
- `server.lua` is loaded from `server/sv_main.lua`
- `types.lua` is for editor type hints and as reference for expected shapes

## Event Flow

Base flow:

`UI -> NUI callback -> client handler -> server callback (optional)`

Common routes:

- Addon button:
  - `custom_functions:button:{name}` on client
  - optional `callServer(...)` to `custom_functions:callback:{name}` on server
- Offline addon button:
  - `custom_functions:offline_button:{name}` on client
  - optional `callServer(...)` to `custom_functions:offline_callback:{name}` on server
- Quick action:
  - `custom_functions:quick_action:{name}` on client (client-only by built-in API)
- Quick toggle:
  - `custom_functions:quick_toggle:{name}` on client (client-only by built-in API)
- Statistic blocks:
  - `custom_functions:statistic_blocks:get` fetches all registered server block callbacks

## Registration API

| Function                                 | File         | Use                                                  |
| ---------------------------------------- | ------------ | ---------------------------------------------------- |
| `RegisterAddons()`                       | `client.lua` | Register buttons, quick actions, quick toggles       |
| `RegisterAddonStatisticBlocks()`         | `client.lua` | Declare statistic block keys                         |
| `RegisterAddonCallback()`                | `server.lua` | Handle server logic for online addon buttons         |
| `RegisterOfflineAddonCallback()`         | `server.lua` | Handle server logic for offline addon buttons        |
| `RegisterAddonStatisticBlocksCallback()` | `server.lua` | Return data for statistic blocks                     |
| `RegisterZoneHandler()`                  | `client.lua` | Register map zone behavior                           |

## Addon Types

Definitions come from `types.lua`.

### 1) Button (Player Management)

Use when action targets a selected player and may require server authority.

- set `type = "button"` in `RegisterAddons(...)`
- handler signature: `function(target, callServer)`
- `target` is selected player server ID
- if using `callServer(...)`, register `RegisterAddonCallback(name, callback, permission?)` on server

### 2) Offline Button (Offline Player Management dialog)

Use when action targets an offline player and runs against the database.

- set `type = "offline_button"` in `RegisterAddons(...)`
- handler signature: `function(target, callServer)`
- `target` is `{ charId, uniqueId, name, identifiers }` (the player is not in the server)
- if using `callServer(...)`, register `RegisterOfflineAddonCallback(name, callback, permission?)` on server
  - server callback signature: `function(source, target, ...)` — `source` is the staff member, `target` is the offline player object
- `callServer` does not pass any source/target args from the client — the offline `target` is already routed automatically

### 3) Quick Action (Quick Menu Main tab)

Use for fast client-side actions with optional option selection.

- built-in path is client-only
- handler signature: `function(target, option)`
- `option` is selected option key or `nil`

### 4) Quick Toggle (Quick Menu Toggles tab)

Use for toggled states (god mode, speed mode, noclip state, etc).

- built-in path is client-only
- handler signature: `function(option)`
- must return a boolean representing new state

### 5) Statistic Blocks (Statistics page)

Use for custom server-backed metrics.

- client declaration:
  - `RegisterAddonStatisticBlocks({ "block_a", "block_b" })`
- server provider:
  - `RegisterAddonStatisticBlocksCallback("block_a", function(source) ... end)`
- expected return:
  - `{ title, description, value, formatToCash? }`
  - `value` can be string or number

### 6) Zone Handler (Admin map zones)

Use for custom behavior when entering/exiting/remaining inside a configured zone.

- register in client:
  - `RegisterZoneHandler("handler_name", function() return { onEnter, onExit, inside } end)`
- zones reference the handler via `customHandler` value
- zone shape reference: see `Zone` in `types.lua`

## Security Requirements (Critical)

Treat every client-triggered path as untrusted.

1. Validate everything server-side:
   - `source`, `target`, option values, ranges, and expected types
2. Use permissions:
   - set addon `permission` and enforce matching permission in `RegisterAddonCallback(...)`
3. Enforce duty/admin state:
   - check `IsOnDuty(source)` (or your project equivalent) before privileged actions
4. Deny by default:
   - reject unknown options and invalid targets early
5. Audit sensitive actions:
   - log who executed what and on whom

## Performance Requirements

FiveM servers are sensitive under player load. Keep custom code lightweight.

- do not run heavy work in per-frame `inside` handlers
- cache expensive statistic computations when possible
- avoid large synchronous loops over all players each click/tick
- for large payloads between client/server, prefer latent events
- fail fast on invalid input to avoid unnecessary work

## Naming and Style Conventions

- use `snake_case` for addon/block/handler names
- names are case-sensitive and must match between client/server registration
- use hex colors like `"#22c55e"`
- icon examples:
  - MDI: `"mdi:heart-pulse"`
  - Material icon theme: `"material-icon-theme:icon-name"`

Reference: https://pictogrammers.com/library/mdi/

## Quick Implementation Recipes

### Add button with server authority

1. In `client.lua`, add addon with `type = "button"` and call `callServer(...)` in handler.
2. In `server.lua`, register `RegisterAddonCallback("same_name", function(source, target, ...) ... end, "optional.permission")`.
3. Validate inputs and enforce permission/duty before executing action.

### Add quick action

1. In `client.lua`, add addon with `type = "quick_action"`.
2. Add optional `options` and implement `handler(target, option)`.
3. Keep behavior client-safe; do not trust this path for privileged logic.

### Add quick toggle

1. In `client.lua`, add addon with `type = "quick_toggle"`.
2. Implement `handler(option)` and return new boolean toggle state.
3. Keep state transitions explicit and deterministic.

### Add statistic block

1. In `client.lua`, include block key in `RegisterAddonStatisticBlocks({ ... })`.
2. In `server.lua`, implement `RegisterAddonStatisticBlocksCallback("same_key", function(source) return {...} end)`.
3. Keep callback fast; cache where possible.

### Add zone behavior

1. In `client.lua`, register `RegisterZoneHandler("handler_name", function() return { onEnter, onExit, inside } end)`.
2. In admin map zone config, set `customHandler` to `"handler_name"`.
3. Keep `inside` callback minimal to prevent frame drops.

## Pre-merge Checklist

- Names match exactly between UI/client/server registrations
- Required server callbacks exist for every `callServer(...)` path
- Permission and duty checks are in place for privileged actions
- Invalid input paths are handled safely
- High-frequency handlers (`inside`) are lightweight
