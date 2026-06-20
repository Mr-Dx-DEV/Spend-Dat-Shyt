# LC Fuel - QBX + JG Garage Setup

This package is prepared to run as `lc_fuel` on QBX/Qbox servers and to work with JG Garages / JG Advanced Garages through the `LegacyFuel` compatibility export.

## Resource Order

```cfg
ensure oxmysql
ensure ox_lib
ensure qbx_core
ensure ox_target
ensure lc_utils
ensure lc_fuel
ensure jg-advancedgarages
```

If you also run a separate JG Garages resource, start it after `lc_fuel` as well.

## JG Config

In `jg-advancedgarages/config/config.lua`, use:

```lua
Config.Framework = "Qbox" -- or "auto" if qbx_core starts before JG
Config.FuelSystem = "LegacyFuel"
```

JG will then call:

```lua
exports["LegacyFuel"]:GetFuel(vehicle)
exports["LegacyFuel"]:SetFuel(vehicle, fuel)
```

`lc_fuel` provides those exports through its manifest and compatibility handlers.

## LC Utils

Set `lc_utils` to your Qbox/QBX framework mode and oxmysql database mode in its own config. `lc_fuel` still depends on `lc_utils` for framework, callbacks, target, notifications, and database helpers.

## Database

Run `install/qbx_jg_lc_fuel.sql` if your `player_vehicles` table does not already have JG's fuel column, or if you want to create the LC fuel type table manually before first start. `lc_fuel` also creates its fuel type table automatically on startup.
