# Oxide Roadside Assistance Job

## Overview

`oxide-roadsideassistancejob` is a roadside assistance gig job where players clock in at a tow yard, receive dispatched service calls, drive a tow truck to stranded motorists, and complete one of four roadside service workflows: fuel help, wheel changes, battery replacements, or towing.

The default package ships with:

- 4 job types
- 40 preconfigured events
- 1 tow yard
- 5 progression levels
- 2-player crews
- 13 tutorial prompts

Players earn persistent progression, daily streak bonuses, crew co-op bonuses, and random tips while a complaint system handles shift abuse such as vehicle destruction or dying on shift.

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
- `vehiclekey`
- `target`
- `progressbar`
- `menu`
- framework lifecycle events

### Database

The resource uses the unified `job_progression` table and stores roadside entries with `job = 'roadside'`.

### Frontend

The packaged UI is Vue 3 + Vite + Tailwind CSS and powers:

- the shift menu
- incoming call notifications
- the in-job HUD
- shift summary screens
- tutorial overlays
- waypoint overlays

### Menu Modes

- `Config.menuStyle = 'nui'`: full Vue menu with camera and crew portraits
- `Config.menuStyle = 'menu'`: lightweight `olink.menu` flow

### Summary Modes

- `Config.shiftSummary = 'nui'`: popup summary on clock-out when `Config.menuStyle ~= 'menu'`
- `Config.shiftSummary = 'text'`: text summary sent through `o-link.phone` when `Config.usePhone = true`, otherwise a toast notification

## Features

- **Dispatch loop**: Calls arrive on a random timer, use grouped event rotation to reduce repetition, and auto clock out the shift after too many missed or declined calls.
- **Four service workflows**: Fueling, wheel changes, battery replacement, and towing each use distinct interactions, props, and repair steps.
- **Distance-based timers**: Time limits are calculated from dispatch acceptance distance rather than fixed per-event mission durations.
- **Persistent progression**: Five levels increase pay multiplier and tip chance, backed by the shared progression table.
- **Crew support**: Two players can share one tow truck, work the same scene, and receive a co-op bonus.
- **Tow truck systems**: Spawned work vehicle includes integrated props, cone storage, key handling through `o-link`, and destruction/damage penalties.
- **Scene safety tools**: Placeable cones and traffic slow zones improve roadside scenes and add cone-based pay bonuses.
- **Builder tooling**: `/roadsidebuilder` creates and exports new tow yards and event sets without editing config files by hand.
- **Tutorials**: First-time prompts guide players through calls, job steps, cones, crews, late jobs, and level-ups.

---

Documentation for setup and operation lives in `docs/INSTALLATION.md`, `docs/CONFIGURATION.md`, `docs/FEATURES.md`, `docs/ADMIN.md`, and `docs/TROUBLESHOOTING.md`.
