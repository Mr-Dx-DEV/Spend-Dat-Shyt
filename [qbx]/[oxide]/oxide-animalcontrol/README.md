# Oxide Animal Control Job

## Overview

`oxide-animalcontroljob` is an animal control gig job where players clock in at the animal control office, receive dispatched service calls, drive an animal control truck to incident locations, and handle one of four job types: aggressive animal takedowns with a tranquilizer dart gun, stray captures using bait and stealth mechanics, wildlife removal with patrol tracking, and deceased animal pickups.

The default package ships with:

- 4 job types
- 55 preconfigured events
- 1 dispatch office
- 5 progression levels
- 2-player crews
- 17 tutorial prompts

Players earn persistent progression, daily streak bonuses, crew co-op bonuses, and random tips while a complaint system handles shift abuse such as animal escapes, kills, vehicle destruction, or dying on shift.

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
- `inventory`
- `target`
- `progressbar`
- `menu`
- framework lifecycle events

### Database

The resource uses the unified `job_progression` table and stores animal control entries with `job = 'animalcontrol'`.

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

### Weapon Model

Includes a bundled tranquilizer dart gun model (WEAPON_G2) with meta files and streamed assets — no additional weapon downloads required.

## Features

- **Dispatch loop**: Calls arrive on a random timer, use grouped event rotation to reduce repetition, and auto clock out the shift after too many missed or declined calls.
- **Four job types**: Aggressive animal takedowns, stray captures with bait and stealth, wildlife removal with patrol tracking, and deceased pickups each use distinct interactions, props, and animal AI.
- **Tranquilizer system**: Server-authoritative dart damage restricted to the active job animal, sedation duration with wakeup mechanic, and ammo resupply at cost.
- **Animal AI**: Distinct behavior per job type — aggressive animals attack NPCs, strays wander and flee when spooked, wildlife patrols waypoints with detection ranges, all with escape radius tracking.
- **Distance-based timers**: Time limits are calculated from dispatch acceptance distance rather than fixed per-event mission durations.
- **Persistent progression**: Five levels increase pay multiplier and tip chance, backed by the shared progression table.
- **Crew support**: Two players can share one truck, work the same scene, and receive a co-op bonus.
- **Reporting NPCs**: Civilian NPCs at job sites cycle through contextual animations and react to player proximity.
- **Scene safety tools**: Tiered speed zones and ambient ped blocking around active job sites.
- **Builder tooling**: `/animalcontrolbuilder` creates and exports new office locations and event sets without editing config files by hand.
- **Tutorials**: First-time prompts guide players through calls, job steps, bait, tranquilizers, crews, and level-ups.

---

Documentation for setup and operation lives in `docs/INSTALLATION.md`, `docs/CONFIGURATION.md`, `docs/FEATURES.md`, `docs/ADMIN.md`, and `docs/TROUBLESHOOTING.md`.
