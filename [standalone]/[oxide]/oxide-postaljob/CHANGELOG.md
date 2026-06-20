# Changelog

## 1.1.0

### Changed
- Migrated from community_bridge to o-link — all `Bridge.*` calls replaced with `olink.*` equivalents across client, server, and shared code
- Unified progression table — `postaljob_progression` merged into shared `job_progression` table with composite `(char_id, job)` primary key
- Vehicle spawning now uses `lib.requestModel()` + `CreateVehicle()` instead of the bridge utility
- Death monitoring replaced with client-side health polling, removing dependency on bridge death events
- `Config.uniformsEnabled` default changed from `true` to `false` (uniforms now opt-in)

### Removed
- Deleted deprecated `exported_locations.lua` file

### Migration (existing servers)
Run `sql/migrate_unified_progression.sql` **once** before updating. This migrates data from `postaljob_progression` into the unified `job_progression` table and drops the old table. Safe to run multiple times.

### Migration Guide
- Back up your database before updating
- Run `sql/migrate_unified_progression.sql` once before starting the updated resource
- This copies data from `postaljob_progression` into `job_progression` and removes the old table
- If you are updating multiple Oxide jobs that use this migration, only run the script once total

## 1.0.5

### Fixed
- Crew member names now display character names (first + last) instead of Steam names in the NUI, notifications, and invite prompts
- Supervisor target zones no longer duplicate when the resource is restarted
- Uniform system now snapshots appearance before applying the outfit, fixing cases where clothing bridges (e.g. illenium-appearance) corrupted the restore data
- Removed dependency on custom `GetIsPlayerDowned` bridge function that prevented the resource from working with the original community_bridge

## 1.0.4

### Fixed
- Fixed race condition in clock-out callback that allowed duplicate shift payments when spamming the clock-out button — shift state is now cleared before payment processing
- Added missing active shift validation on clock-out, preventing callbacks from executing without a valid shift

## 1.0.3

### Added
- `Config.uniformsEnabled` option in `config/outfits.lua` to disable work uniforms entirely — set to `false` to hide the uniform button from both NUI and context menus and block all uniform server callbacks

## 1.0.2

### Fixed
- Phone notifications now use email instead of SMS, fixing errors on phone resources (lb-phone, okokPhone, qb-phone, etc.)
- Players can no longer clock in when the vehicle spawn area is occupied by another player or vehicle
- Co-op partners now receive vehicle keys so they can open and close van doors
- Fixed carry prop occasionally failing to attach without blocking the delivery flow

### Changed
- Updated map blip icon and color

## 1.0.1

### Fixed
- Fixed "Failed to load data" error when interacting with the GoPostal NPC on ESX, QBCore, and QBX frameworks
- Player progression now works correctly with all identifier formats (ESX license strings, QBCore citizenids)

### Changed
- `char_id` column type changed from `INT UNSIGNED` to `VARCHAR(60)` to support all framework identifier formats

### Migration (existing servers)
If you already have the `postaljob_progression` table from v1.0.0, run this SQL before updating:

```sql
ALTER TABLE postaljob_progression MODIFY char_id VARCHAR(60) NOT NULL;
```

New installs require no action — the updated `sql/install.sql` handles this automatically.
