# Voice Gesture

`Voice Gesture` adds automatic talking animations based on the player's active `pma-voice` range.

This package is intended for Tebex escrow delivery.

## Features

- Automatic talking animations while the player is speaking
- Different animation behavior for `whisper`, `normal`, and `shout`
- Mood selector with `ox_lib`
- Per-player saved mood preferences
- Server-side persistence
- Framework support for:
  - `qbx_core`
  - `qb-core`
  - `es_extended`
- Compatible with:
  - `pma-voice`
  - `ox_lib`
  - `oxmysql`
  - `ox_inventory`
  - `DeadoAnimationPackV3` pointing
  - `scully_emotemenu` pointing

## Dependencies

Make sure these resources are installed and started:

- `pma-voice`
- `ox_lib`
- `oxmysql`

Optional integrations:

- `ox_inventory`
- `qbx_core`, `qb-core`, or `es_extended`
- `DeadoAnimationPackV3`
- `scully_emotemenu`

## Install

1. Place the `voicegesture` resource in your server resources folder.
2. Make sure dependencies start before `voicegesture`.
3. Add this to your server start order:

```cfg
ensure oxmysql
ensure ox_lib
ensure pma-voice
ensure voicegesture
```

If you use a framework, make sure it is started before `voicegesture` as well.

Examples:

```cfg
ensure qbx_core
ensure oxmysql
ensure ox_lib
ensure pma-voice
ensure voicegesture
```

```cfg
ensure qb-core
ensure oxmysql
ensure ox_lib
ensure pma-voice
ensure voicegesture
```

```cfg
ensure es_extended
ensure oxmysql
ensure ox_lib
ensure pma-voice
ensure voicegesture
```

## Database

`voicegesture` will automatically create its own table on resource start:

- `voicegesture_moods`

No manual SQL import is required.

## Commands

- `/mood`
  Opens the `ox_lib` mood menu.

- `/moodreset`
  Resets all saved moods back to `Normal`.

## Mood System

Players can choose a different speaking mood for each voice range:

- `Whisper`
- `Normal`
- `Shout`

Available moods:

- `Normal`
  Relaxed / default

- `Argue`
  Intense / animated

- `Sad`
  Head down / withdrawn

`Sad` is available for:

- `Whisper`
- `Normal`

`Sad` is not available for:

- `Shout`

Player mood selections are saved automatically and restored after reconnecting.

## Persistence

This resource saves moods per player using the best available identity for your server:

- `qbx_core` -> `citizenid`
- `qb-core` -> `citizenid`
- `es_extended` -> `identifier`
- fallback -> Rockstar license

## Behavior Notes

- Talking animations are driven by the player's active `pma-voice` mode.
- Pointing will override the talking animation.
- When pointing stops, the talking animation can resume if the player is still speaking.
- Item use through `ox_inventory` will temporarily block the talking animation until the item action is complete.
- `Sad` mood disables the head-turn look behavior so the posture stays more downcast.

## Escrow Notes

Because this resource is intended to be escrow protected:

- Buyers will not have access to locked `client.lua` and `server.lua`
- Buyers can still install, start, and use the resource normally
- Buyers can still manage dependency order from `server.cfg`

If you plan to expose editable config files in the future, document those separately.

## Troubleshooting

### `/mood` does not open

Check:

- `ox_lib` is installed
- `ox_lib` is started before `voicegesture`

### Animations do not play

Check:

- `pma-voice` is installed and started
- the player is actually talking
- the player is not sprinting, aiming, shooting, pointing, or using an item

### Saved moods do not persist

Check:

- `oxmysql` is installed and started
- your framework is started before `voicegesture`
- the `voicegesture_moods` table exists

### F8 shows `ResizeObserver loop limit exceeded`

This is usually an `ox_lib` / Chromium UI warning, not a Lua crash.
If the menu still works, it is generally harmless.

## Support Info

When requesting support, provide:

- framework name and version
- voice resource name
- whether you use `ox_inventory`
- whether you use `DeadoAnimationPackV3` or `scully_emotemenu`
- full server console error
- full F8 error

