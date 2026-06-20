## Cosmic Crafts Store

### Car Menu
A comprehensive, zero-dependency vehicle interaction menu for FiveM servers. This script provides an intuitive interface for controlling various vehicle features including doors, windows, lights, indicators, engine, and more - all accessible to both drivers and passengers with configurable permissions.

## Features

### 🚗 **Vehicle Controls**
- **Doors & Windows**: Control individual doors and windows
- **Lights**: Interior lights, parking lights, hazard lights, and indicators
- **Engine**: Start/stop vehicle engine
- **Neon**: Toggle neon lights on/off
- **Special Features**: Hood and trunk controls

### 🚤 **Boat Support**
- **Anchor System**: Drop and raise boat anchors
- **Position Tracking**: Copy boat coordinates for navigation
- **Water Detection**: Smart anchoring with depth validation

### 👥 **Passenger Mode**
- **Configurable Permissions**: Set what passengers can control
- **Special Vehicle Support**: Custom permissions for specific vehicle types
- **Seat Management**: Switch between seats with permission checks

### 🎮 **User Experience**
- **Keyboard Shortcuts**: Z key to toggle menu, Escape to close
- **Responsive UI**: Clean, intuitive interface
- **Permission Feedback**: Clear notifications for access control
- **Emergency Recovery**: Double-tap Z to recover stuck menu

## Framework Support

- **ESX Legacy**: Full integration with ESX framework
- **QBCore**: Compatible with QBCore framework
- **Standalone**: Zero-dependency mode for any server
- **ox_lib**: Optional integration for enhanced notifications and keybinds

## Installation

### 1. Download & Install
```bash

# Navigate to your resources folder

```

### 2. Configure Framework
Edit `config.lua` to set your preferred framework:

```lua
Config.Framework = {
    UseFramework = 'esx', -- Options: 'esx', 'qbcore', 'standalone', 'none'
    UseOxLib = true,      -- Set to false if not using ox_lib
}
```

### 3. Server Configuration
Add to your `server.cfg`:
```cfg
ensure cosmic_carmenu
```

### 4. Dependencies (Optional)
If using ox_lib integration:
```cfg
ensure ox_lib
```

## Configuration

### Framework Settings
```lua
Config.Framework = {
    UseFramework = 'esx',     -- Choose your framework
    UseOxLib = true,          -- Enable ox_lib features
}
```

### Passenger Permissions
```lua
Config.PassengerMode = {
    NotifyOnDenied = true,    -- Show access denied messages
    
    Permissions = {
        Doors = true,          -- Control doors
        Windows = true,        -- Control windows
        InteriorLights = true, -- Control interior lights
        Engine = false,        -- Control engine (driver only)
        Indicators = true,     -- Control indicators
        Hazards = true,        -- Control hazard lights
        ParkingLights = true,  -- Control parking lights
        LicensePlate = false,  -- Access license plate
        SeatSwitching = true,  -- Switch seats
        Neon = false,          -- Control neon lights
    }
}
```

### Special Vehicle Permissions
```lua
Config.PassengerMode.SpecialVehicles = {
    ['police'] = {
        Doors = true,
        Windows = true,
        Engine = true,         -- Police can control engine
        Indicators = true,
        Hazards = true,
    },
    ['ambulance'] = {
        Doors = true,
        Windows = true,
        Engine = true,         -- EMS can control engine
        Indicators = true,
        Hazards = true,
    }
}
```

## Usage

### Basic Controls
- **Z Key**: Toggle vehicle menu
- **Escape**: Close menu
- **Double Z**: Emergency menu recovery

### Menu Features
1. **Seat Selection**: Click seat icons to switch positions
2. **Door Control**: Toggle individual doors open/closed
3. **Window Control**: Roll windows up/down
4. **Light Control**: Interior, parking, hazard, and indicator lights
5. **Engine Control**: Start/stop vehicle (driver only)
6. **Special Controls**: Hood, trunk, neon lights

### Boat Features
- **Anchor Button**: Drop/raise boat anchor
- **Position Copy**: Copy coordinates for navigation
- **Speed Check**: Automatic speed validation for anchoring

## Commands

| Command | Description |
|---------|-------------|
| `/carmenu` | Open vehicle menu |
| `/fixcarmenu` | Fix stuck menu state |

## Keybinds

| Key | Action |
|-----|--------|
| `Z` | Toggle vehicle menu |
| `Escape` | Close menu |
| `Double Z` | Emergency menu recovery |


## Troubleshooting

### Menu Not Opening
1. Ensure you're inside a vehicle
2. Check if the resource is started: `ensure cosmic_carmenu`
3. Use `/fixcarmenu` command
4. Double-tap Z for emergency recovery

### Framework Issues
1. Verify framework is running (`es_extended` or `qb-core`)
2. Check `config.lua` framework settings
3. Ensure proper export names for your framework version

### Permission Problems
1. Check passenger permissions in `config.lua`
2. Verify special vehicle configurations
3. Ensure player has proper group permissions

## Support

For issues and support:
1. Check the configuration settings
2. Verify framework compatibility
3. Review console for error messages
4. Test in standalone mode first

## License

This script is provided as-is for FiveM server use. Modify and distribute as needed for your community.



**Note**: This script is designed to work with any FiveM server setup and provides a comprehensive vehicle control system without external dependencies (unless specifically configured). Developed by Cosmic Crafts Store. 