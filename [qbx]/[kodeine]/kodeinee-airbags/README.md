# Kodeinee Airbags
By Kodeinee Studios

## Install
1. Drag `kodeinee-airbags` into your resources folder.
2. Add this to `server.cfg`:
   ```cfg
   ensure kodeinee-airbags
   ```
3. Edit only `config.lua`.

## How It Works
Airbags deploy automatically when the driver crashes above the configured speed.

Default trigger:
- Driver is going over `Config.DeploySpeed = 30.0`
- Speed unit is `mph`
- Vehicle loses at least `Config.SpeedDropRequired = 10.0` speed from the impact

No install item is required. The old item/install system has been fully removed.

## Commands
- `/removeairbag` - removes airbags from the vehicle you are driving
- `/clearairbags` - removes nearby deployed airbag props

## Config
Main settings:
```lua
Config.SpeedUnit = 'mph'
Config.DeploySpeed = 30.0
Config.SpeedDropRequired = 10.0
Config.DriverOnly = true
```

Set `Config.Debug = true` if you want console prints showing the stored speed and crash check values while testing.
