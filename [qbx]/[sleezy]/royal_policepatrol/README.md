# Royal Police Patrol - Enhanced MDT System

A comprehensive police patrol system for FiveM with enhanced dispatch, crime generation, and Mobile Data Terminal (MDT) features. Supports both ESX and QBCore frameworks automatically.

## Features

- ✅ **Patrol System** - Start/stop patrols with keybind or commands
- ✅ **Dynamic Crime Generation** - Random crimes spawn during patrol
- ✅ **Enhanced Dispatch System** - Priority 1-5 dispatch alerts with NUI
- ✅ **MDT (Mobile Data Terminal)** - Access officer information and records
- ✅ **Crime Response Logging** - Log and view crime response records
- ✅ **Multi-Framework Support** - Auto-detects ESX or QBCore

---

## Installation

1. Place the `royal_policepatrol` folder in your `resources` directory.
2. Add to **server.cfg**: `ensure royal_policepatrol`
3. Edit **shared/config.lua** for police jobs, crimes, and keybinds (Tebex: only files in `escrow_ignore` are editable).
4. Restart your server.

No Ace permissions are required for patrol/MDT; access is controlled by **Config.PoliceJobs** in `shared/config.lua`. For admin commands (`/testdispatch`, `/dispatchhistory`, etc.), ensure your framework assigns an admin group or add Ace permissions if the script checks for them.

---

## Basic Usage

### Starting a Patrol

**Command:**
```
/patrol
```
or
```
/startpatrol
```

**Keybind:**
- Press `F6` (configurable in `shared/config.lua`)

### Stopping a Patrol

**Command:**
```
/stoppatrol
```
or toggle with `/patrol`

### Opening MDT (Mobile Data Terminal)

**Command:**
```
/mdt
```

The MDT displays:
- Officer information (name, badge number)
- Patrol status
- Active call information
- Crime response records

### Clearing a Crime

When you encounter a crime during patrol, clear it with:

**Command:**
```
/clearcrime
```

---

## Crime Response Logging

### Overview

The system stores crime response records server-side (in memory) with the following information:
- **Crime Type** - Type of crime that was responded to
- **Location** - Where the crime occurred
- **Outcome** - Result of the response (resolved, suspect fled, suspect arrested)
- **Officer** - Officer who logged the response
- **Timestamp** - When the response was logged

### Logging a Crime Response

To log a crime response, use the following command:

**Command:**
```
/logcrime <crime_type> <outcome> [location_string]
```

**Parameters:**
- `<crime_type>` - The type of crime (e.g., `assault`, `armed_robbery`, `disturbance`)
- `<outcome>` - The outcome of the response:
  - `resolved` - Crime was resolved successfully
  - `suspect_fled` - Suspect fled the scene
  - `suspect_arrested` - Suspect was arrested
- `[location_string]` - (Optional) Location description (defaults to "Current Location")

**Examples:**
```
/logcrime assault resolved
/logcrime armed_robbery suspect_arrested "Vinewood Blvd & Alta St"
/logcrime disturbance suspect_fled "Downtown Los Santos"
```

### Viewing Crime Response Records

Crime response records are automatically displayed in the MDT:

1. Open the MDT with `/mdt`
2. Scroll down to the **CRIME RESPONSE RECORDS** section
3. View the last 50 records (most recent first)

Each record shows:
- Crime type
- Outcome (with color coding)
- Location
- Responding officer
- Date and time

### Outcome Color Coding

- 🟢 **Resolved** (Green) - Crime resolved successfully
- 🟠 **Suspect Fled** (Orange) - Suspect escaped
- 🔵 **Suspect Arrested** (Blue) - Suspect was arrested

---

## Dispatch System

### Dispatch Priorities

The system uses 5 priority levels:

1. **CODE 1 - Minor** (Green) - Low priority, routine calls
2. **CODE 2 - Low** (Yellow) - Standard priority
3. **CODE 3 - Urgent** (Orange) - Moderate priority, requires prompt response
4. **CODE 4 - Emergency** (Red) - High priority, immediate response needed
5. **CODE 5 - Critical** (Purple) - Maximum priority, life-threatening situation

### Responding to Dispatches

When a dispatch alert appears:

- **Press `E`** or click **RESPOND** - Accept the dispatch and set waypoint
- **Press `Q`** or click **IGNORE** - Ignore the dispatch

Dispatches automatically expire after a set time based on priority level.

---

## Configuration

All configuration is done in `shared/config.lua`:

### Police Jobs

Configure which jobs can use patrol features:

```lua
Config.PoliceJobs = {
    'police',
    'sheriff',
    'lspd',
    'bcso',
    -- Add your police jobs here
}
```

### Crime Types

Configure available crime types in `Config.Crimes`:

```lua
Config.Crimes = {
    ['traffic_stop'] = {
        label = 'Traffic Stop',
        severity = 1,
        violentChance = 0.1,
        weaponChance = 0.05,
        radius = 150.0,
    },
    -- Add more crime types
}
```

### Keybinds

Change keybinds in the config:

```lua
Config.Patrol.Keybind = 'F6'  -- Patrol toggle keybind
Config.Dispatch.Keybinds.Accept = 'E'  -- Accept dispatch
Config.Dispatch.Keybinds.Ignore = 'Q'  -- Ignore dispatch
```

---

## Admin Commands

### Test Dispatch

Send a test dispatch to all officers on patrol:

```
/testdispatch [priority]
```

- `[priority]` - Priority level 1-5 (default: 3)

### View Dispatch History

View recent dispatch history (admin only):

```
/dispatchhistory [count]
```

- `[count]` - Number of records to show (default: 10, max: 20)

### View Active Dispatches

View all active dispatches (admin only):

```
/activedispatches
```

### List Active Patrols

View all officers currently on patrol (admin only):

```
/patrollist
```

---

## Framework Integration

The script automatically detects your framework (ESX or QBCore). No manual configuration needed!

### ESX Support
- Auto-detects `es_extended` or `esx_core`
- Uses ESX notification system
- Gets player data from ESX

### QBCore Support
- Auto-detects `qb-core`
- Uses QBCore notification system
- Gets player data from QBCore

---

## Crime Response Storage

### Current Implementation

- **Storage**: In-memory (server-side)
- **Capacity**: Up to 500 records (most recent kept)
- **Persistence**: Lost on server restart

### Future Enhancements

SQL database integration is planned for future updates to provide persistent storage.

---

## Troubleshooting

### MDT Not Opening

1. Ensure you have a police job configured in `Config.PoliceJobs`
2. Check console for errors
3. Verify framework is detected correctly

### Dispatches Not Appearing

1. Make sure you're on patrol (`/patrol`)
2. Check that crimes are being generated (wait 30-60 seconds)
3. Verify NUI files are loaded correctly

### Crime Responses Not Showing

1. Ensure you've logged at least one crime response (`/logcrime`)
2. Check that the MDT is open and scrolled to the records section
3. Verify server exports are working

---

## Support

For issues, feature requests, or questions:

- Check the configuration file for customization options
- Review server console for debug messages (enable `Config.Debug = true`)
- Ensure all dependencies are properly installed

---

## License

Created by RoyalT Customz

---

## Version History

### v1.1.0
- Added crime response logging system
- Enhanced MDT with crime response records display
- Added `/logcrime` command for logging responses
- Server-side storage for crime response records

### v1.0.0
- Initial release
- Patrol system
- Crime generation
- Enhanced dispatch system
- Basic MDT

