# Changelog

## [1.1.0]

### Added
- Configurable outfit/uniform system with male and female outfit definitions (`shared/config/outfits.lua`)
- Uniform toggle in both NUI shift menu and bridge context menu with `Config.uniformsEnabled` (default: disabled)
- Server-side appearance backup and restore on uniform apply/remove
- Uniform auto-reverts on clock out, death, disconnect, and resource stop
- Migration script (`sql/migrate_unified_progression.sql`) for safe data migration from per-job progression tables
- Transaction reason strings on all payment and fine operations for audit trail

### Changed
- Migrated from `community_bridge` to `o-link` bridge across all server and client code
- Updated fxmanifest dependency from `community_bridge` to `o-link`
- Replaced all `Bridge.*` API calls with `olink.*` equivalents
- Updated lifecycle events to `olink:client:playerReady` / `olink:client:playerUnload`
- Unified progression storage from per-resource `animalcontroljob_progression` table to shared `job_progression` table with composite `(char_id, job)` key

### Fixed
- Vehicle fuel now set to full on spawn

### Migration Guide
- Back up your database before updating
- Run `sql/migrate_unified_progression.sql` once before starting the updated resource
- This copies data from `animalcontroljob_progression` into `job_progression` and removes the old table
- If you are updating multiple Oxide jobs that use this migration, only run the script once total

## [1.0.1]

### Fixed
- Crew member names now display character names instead of Steam names in the NUI and notifications

## [1.0.0] - 2026-03-25

### Added
- Initial release of the animal control gig job
- 4 job types: aggressive animal, stray capture, wildlife removal, and deceased pickup
- 55 preconfigured events across the city (13 aggressive, 15 stray, 5 wildlife, 22 deceased)
- Tranquilizer dart gun system with inventory-managed weapon and limited ammo per call (5 darts)
- Bait placement system with ghost preview, scent particle effects, and player retreat mechanics
- Stealth detection system with configurable native crouch detection or random chance fallback
- Animal behavior AI: aggressive combat targeting, stray flee/approach cycles, wildlife waypoint patrols, deceased ragdoll states
- Animal state machine: ALIVE, SEDATED, CAPTURED, LOADED, DEAD with transition logic
- Sedation wake-up timer (30 seconds) requiring re-tranquilization
- Escape radius detection per job type with complaint penalties
- Animal kill detection with fine ($150) and complaint
- Reporting NPC system with civilian models, reaction animations, and thank-you gestures on job completion
- World NPC flee behavior around aggressive animals and wildlife
- Shelter delivery system for live animal transport to `Config.ShelterDeliveryPoint`
- Deceased remains collection with body bag prop and carry animation
- Call dispatch system with configurable intervals (15-45s) and 30-second response window
- 5-tier progression system (Volunteer, Handler, Senior Handler, Field Supervisor, Chief Officer) with persistent database tracking
- 2-player crew co-op system with shared calls, vehicle sharing, and 15% co-op pay bonus
- Payment system with base pay, distance bonus, speed bonus, level multiplier, streak bonus, tips, gas fees, and taxes
- Complaint system with animal escape, animal kill, vehicle destruction, and death penalties; 30-minute timeout after 3 strikes
- Server-authoritative mission timers calculated from base time plus distance
- NUI frontend with mission timer, incoming call notification, shift menu with cinematic camera, shift summary screen, and tutorial tooltips
- 3D floating waypoint system (hold H to show) with distance-based scaling
- Dual menu style support: NUI (cinematic camera, crew headshots) and Bridge.Menu (lightweight context menu)
- Phone integration via community_bridge for shift emails and notifications
- Safety zones around animal scenes with speed zone tiers for NPC traffic
- Admin builder tool (`/animalcontrolbuilder`) for creating office locations and job events
- Tutorial commands (`/animalcontroltutorials` toggle, `/animalcontroltutorialreset` reset)
- 17 contextual tutorial tooltips for new player onboarding
- Database table `animalcontroljob_progression` for persistent progression
- Dart weapon damage restriction (only affects active job animals while on shift)
- Animal model registry with 14 animal types including dogs, cats, coyotes, mountain lions, panthers, and deer
- English locale (`locales/en.json`)
