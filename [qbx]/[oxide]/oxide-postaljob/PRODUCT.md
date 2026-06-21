# Oxide Postal Job

## Overview

`oxide-postaljob` is a GoPostal delivery gig job where players clock in at a depot, load packages or collect mail bags, drive a company van to addresses, and deliver to customers or letterboxes.

The default package ships with:

- 2 task types
- 35 delivery zones
- 20 letterboxes
- 1 depot
- 5 progression levels
- 2-player crews
- 9 tutorial prompts

Players earn persistent progression, daily streak bonuses, crew co-op bonuses, and random tips while a complaint system handles shift abuse such as vehicle destruction or dying on shift. Non-shift players see visual-only pallets at depots when others are loading, adding ambient immersion.

## Technical

| Dependency | Required | Purpose |
|---|---|---|
| `o-link` | Yes | Framework and system abstraction layer used by the resource |
| `ox_lib` | Yes | Locale, callbacks, timers, context/input UI, and utility functions |
| `oxmysql` | Yes | Database access for progression data |

### `o-link` modules used

- `character`
- `notify`
- `phone`
- `money`
- `clothing`
- `fuel`
- `vehiclekey`
- `target`
- `menu`
- framework lifecycle events

### Database

The resource uses the unified `job_progression` table and stores postal entries with `job = 'postal'`.

### Frontend

The packaged UI is Vue 3 + Vite + Tailwind CSS and powers:

- the shift menu
- the in-job delivery HUD
- shift summary screens
- tutorial overlays
- waypoint overlays

### Menu Modes

- `Config.menuStyle = 'nui'`: full Vue menu with cinematic camera and crew portraits
- `Config.menuStyle = 'menu'`: lightweight `olink.menu` flow

### Summary Modes

- `Config.shiftSummary = 'nui'`: popup summary on clock-out when `Config.menuStyle ~= 'menu'`
- `Config.shiftSummary = 'text'`: phone email sent through `o-link.phone` on clock-out; when `Config.menuStyle = 'menu'`, a notification is shown instead

## Features

- **Dual task types**: Each batch randomly assigns package deliveries (pallet loading, customer handoff with reaction animations) or letter rounds (post box collection, letterbox drops), keeping shifts fresh across sessions.
- **Progression and leveling**: Five tiers from Trainee to Head Postman with increasing pay multipliers, tip chances, batch sizes, and tighter route clustering. Progress is persistent and earned through cumulative delivery completions.
- **Route intelligence**: Spread-aware zone selection gives low-level players exploratory routes across the map while high-level players get tight clusters for efficient grinding. Nearest-neighbor sorting ensures logical driving loops.
- **Crew co-op**: Two players can team up on the same shift with a shared van, synchronized loading and delivery, and a 15% co-op pay bonus. Leadership transfers gracefully if one member drops out.
- **Detailed pay breakdown**: Base pay plus distance bonus, on-time speed bonus, level multiplier, daily streak bonus, and random tips. Deductions for early clock-out, vehicle damage, gas fees, and taxes keep the economy grounded.
- **Customer reactions**: NPCs spawn at delivery points and react to timeliness with distinct animations and walk speeds.
- **Bystander immersion**: Non-shift players see visual-only pallets at depots when others are loading, with real-time box count updates via statebag sync.
- **Uniform system**: Toggle a GoPostal uniform on or off through the supervisor menu with separate male and female outfit configs.
- **Builder tooling**: `/postalbuilder` creates and exports new depots with delivery zones, letterbox scanning, and post box placement without editing config files by hand.
- **Anti-abuse system**: Complaint tracking with automatic timeouts after repeated strikes. Complaints decay through successful deliveries.
- **Tutorials**: Nine first-time prompts guide players through clocking in, loading, delivering, crews, and level-ups.

---

Documentation for setup and operation lives in `docs/INSTALLATION.md`, `docs/CONFIGURATION.md`, `docs/FEATURES.md`, `docs/ADMIN.md`, and `docs/TROUBLESHOOTING.md`.
