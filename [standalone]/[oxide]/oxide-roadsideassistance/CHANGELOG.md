# Changelog

## [1.1.0] - 2026-04-14

### Added
- Configurable outfit system — opt-in uniforms for male/female with automatic revert on clock-out, respawn, and disconnect (`shared/config/outfits.lua`)
- Tow truck now spawns with full fuel

### Changed
- Migrated progression data from `roadsideassistancejob_progression` to unified `job_progression` table (migration script: `sql/migrate_unified_progression.sql`)
- Refactored shift finalization into reusable `RoadsideFinalizeShift()` function with proper partner handling during auto-clockout
- Centralized auto-clockout logic in `RoadsideHandleAutoClockOut()` — removed duplicate code from call rejection and missed call handlers

### Fixed
- Tow vehicle reattachment no longer breaks mission flow when detaching and re-hooking mid-tow
- Vehicle spawn failure during clock-in now properly aborts shift and notifies the player instead of silently failing
- Clock-out now validates server response and displays error notification on failure
- Partner damage charges and breakdowns now correctly applied during simultaneous crew finalization

### Migration Guide
- Back up your database before updating
- Run `sql/migrate_unified_progression.sql` once before starting the updated resource
- This copies data from `roadsideassistancejob_progression` into `job_progression` and removes the old table
- If you are updating multiple Oxide jobs that use this migration, only run the script once total

## [1.0.2]

### Fixed
- Crew member names now display character names instead of Steam names in the NUI and notifications

## [1.0.1] - 2026-03-26

### Changed
- Mission timers are now server-authoritative and distance-based — replaced hardcoded `missionTime` per event with dynamic calculation using `Config.Timer.baseTime + distance * Config.Timer.timePerDistanceUnit`
- Removed `extraTime` config option — timer is now a single computed value
- Removed `missionTime` field from all event definitions in `shared/config/events.lua`

### Fixed
- Towed vehicle freezing permanently when detached mid-tow — removed the re-freeze on detach outside delivery zone so players can re-hook and continue the mission

## 1.0.0

### Added
- Initial release of the roadside assistance gig job
- 4 service types: fuel help, wheel change, battery replacement, and vehicle towing
- 40 preconfigured events across all job types (10 fuel, 10 wheel, 10 battery, 10 towing)
- Call dispatch system with configurable intervals (15-45s) and 30-second response window
- 5-tier progression system (Trainee, Mechanic, Senior Technician, Team Lead, Master Technician) with persistent database tracking
- 2-player crew co-op system with shared calls, vehicle sharing, and 15% co-op pay bonus
- Safety cone system with 3 placeable cones, ghost preview placement, tiered speed zones, and per-cone pay bonus
- Props system with jack, spare wheel, jerry can, and battery — truck-mounted with third-eye take/return interactions
- Stranded NPC behavior with exit animations, proximity-based animation cycling, and impatient reactions
- Breakdown visual effects: hazard lights, cosmetic damage, engine smoke, flat tires
- Payment system with base pay, distance bonus, speed bonus, cone bonus, level multiplier, streak bonus, tips, gas fees, and taxes
- Complaint system with vehicle destruction and death penalties, 30-minute timeout after 3 strikes, complaint decay per completed job
- NUI frontend with mission timer, incoming call notification, shift menu with cinematic camera, shift summary screen, and tutorial tooltips
- 3D floating waypoint system (hold H to show) with distance-based scaling
- Dual menu style support: NUI (cinematic camera, crew headshots) and Bridge.Menu (lightweight context menu)
- Phone integration via community_bridge for shift emails and notifications
- Admin builder tool (`/roadsidebuilder`) for creating tow yard locations and job events
- Tutorial commands (`/roadsidetutorials` toggle, `/roadsidetutorialreset` reset)
- Database table `roadsideassistancejob_progression` for persistent progression
- English locale (`locales/en.json`)
