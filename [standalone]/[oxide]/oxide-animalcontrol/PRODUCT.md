# Oxide Animal Control Job

## Overview

A fully-featured animal control gig job where players clock in at a dispatch office, receive randomized service calls, drive an animal control truck to incident locations, and handle 4 distinct job types — aggressive animal takedowns with a tranquilizer dart gun, stray captures using bait and stealth mechanics, wildlife removal with patrol tracking, and deceased animal pickups. A 5-tier progression system (Volunteer to Chief Officer) unlocks better pay multipliers and tip chances as players level up through completed jobs. Two players can team up in crews for shared calls with a 15% co-op pay bonus, and a complaint system temporarily suspends players who let animals escape, kill animals, or destroy their truck.

## Technical

| Dependency | Required | Purpose |
|---|---|---|
| `o-link` | Yes | Framework and system abstraction layer used by the resource |
| `ox_lib` | Yes | Locale, callbacks, timers, context/input UI, and utility functions |
| `oxmysql` | Yes | Database access for progression data |

**Database:** Uses the unified `job_progression` table, storing animal control entries with `job = 'animalcontrol'`. Tracks per-character level, total jobs, daily streak, complaints, and timeout state.

**Frontend:** Vue 3 + Vite + Tailwind CSS — renders the shift menu with cinematic camera and crew headshot portraits, incoming call notifications, job HUD overlay with mission timer and context hints, end-of-shift payment summary, tutorial tooltips, and 3D floating waypoints.

**Menu Style:** Configurable between the full NUI menu (cinematic camera, crew portraits, progression card) and a lightweight `olink.menu` context menu for servers that prefer simplicity or don't need the NUI frontend.

**Weapon Model:** Includes a bundled tranquilizer dart gun model (WEAPON_G2) with meta files and streamed assets — no additional weapon downloads required.

## Features

- **4 Job Types** — Aggressive animal (tranquilize attacking animal, load into truck, deliver to shelter), stray capture (place bait, sneak up, calm and capture), wildlife removal (track patrolling animal through waypoints, tranquilize and deliver), and deceased pickup (collect remains into a body bag, load into truck). Each type has unique animal AI, prop interactions, animations, and mission timers.

- **Tranquilizer Dart System** — A dart gun is given on clock-in and removed on clock-out. Dart damage is server-authoritative and restricted to only affect the active job's animal while on shift. Successful hits sedate the animal for a configurable duration (default 30s), after which it wakes up and must be re-tranquilized. Ammo resupplies are available at a cost, deducted from shift pay.

- **Animal AI Behavior** — Each job type drives distinct AI. Aggressive animals attack the reporting NPC and redirect to the player. Strays wander and flee when spooked, with configurable spook chances and flee distances. Wildlife patrols between waypoints with detection ranges for standing vs crouching players. All animals have escape radii that trigger complaints if breached.

- **Bait & Stealth Mechanics** — Take bait from the truck, place it using a ghost preview system, then retreat and wait for the stray to approach. Crouch to avoid spooking the animal while closing in. Supports native crouch detection or a random-chance fallback for servers with custom crouch systems.

- **Call Dispatch System** — Randomized service calls dispatched at configurable intervals (15-45s). Players accept or decline via keyboard with a 30-second response window. Missed and declined calls accumulate — 3 missed calls trigger automatic clock-out. An event pool of 55 locations avoids repetition across a shift.

- **Progression & Leveling** — 5 tiers (Volunteer to Chief Officer) with increasing pay multipliers (1.0x to 1.5x), tip chances (10% to 40%), and tip ranges. Progress is persistent and earned through cumulative job completions. A daily streak system (up to 7 days) adds bonus pay.

- **Crew Co-op** — Two players can team up on the same shift with a shared truck, synchronized call dispatch, and a 15% co-op pay bonus. Leadership transfers gracefully if one member clocks out or disconnects.

- **Detailed Pay Breakdown** — Base pay per job type plus distance bonus, speed bonus for on-time completion, level multiplier, daily streak bonus, and random tips. Deductions for gas fees (5%), taxes (10%), vehicle damage charges, and fines. End-of-shift summary shows the full breakdown via NUI popup or email notification.

- **Reporting NPC Behavior** — Civilian NPCs spawn at aggressive and stray job sites, cycling through contextual animations (beckoning, frightened, phone calls) based on player proximity. NPCs play thank-you animations on job completion.

- **Safety Zones** — Tiered speed zones (8 mph inner, 20 mph outer) slow NPC traffic around active job sites. Ambient ped scenarios are blocked and parked vehicles are cleared to reduce interference.

- **Tutorial System** — 17 contextual tooltips guide new players through their first shift, covering every job type, bait placement, tranquilizer use, animal loading, shelter delivery, crew mechanics, and progression. Tutorials persist via KVP and can be toggled or reset with commands.

- **Phone Integration** — Email notifications for shift events, dispatch calls, incident reports, and end-of-shift payment summaries via `o-link.phone`.

- **Location Builder** — Built-in admin tool (`/animalcontrolbuilder`) for creating new office locations and job events with ACE permissions — no code editing required.

- **Anti-Abuse System** — Complaint tracking with automatic 30-minute timeouts after 3 strikes (animal escape, animal killed, vehicle destroyed, player death). Complaints decay through successful job completions.

---

*~10,600 lines of code*
