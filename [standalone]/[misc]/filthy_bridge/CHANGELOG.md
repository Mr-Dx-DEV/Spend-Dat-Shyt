# Changelog


### 🎯 ESX Duty System

- **Added server-side duty tracking** via `PlayerDutyStatus` table
  - Tracks duty status per player source ID
  - Initializes to `true` on `esx:playerLoaded` event
  - Clears on `esx:playerDropped` event
  - Added `CreateThread` initialization for already-logged-in players when bridge starts

- **Added `FLBridge.getJobData` fix for ESX**
  - Now returns `job.onduty = true` by default if no duty status tracked
  - This ensures ESX players are considered on-duty unless explicitly toggled off
  - Fixes issues with scripts checking `job.onduty` (e.g., tow driver detection)

- **Added duty status update event**
  - Added `flb:setDutyStatus` server event for external scripts to update duty
  - Added `flb:updateDuty` client event handler for syncing duty changes

- **Added `FLBridge.isOnDuty` server function**
  - Returns current duty status for a player
  - Defaults to `true` if no status tracked

- **Added client-side `FLBridge.toggleDuty` function**
  - Uses `ESX.SetPlayerData("job", job)` pattern (like wasabi_bridge)
  - Fires `flb:setDutyStatus` to sync with server tracking
  - Fires `flb:onDutyToggle` event for other scripts

### 💰 ESX Money Functions

- **Fixed `FLBridge.addMoney` for ESX**
  - Changed from `xPlayer.addMoney(type, amount)` to `xPlayer.addAccountMoney(type, amount)`
  - This is the correct ESX Legacy API for adding account money
  - Maps `cash` to `money` for ESX compatibility

- **Fixed `FLBridge.removeMoney` for ESX**
  - Changed from `xPlayer.removeMoney(type, amount)` to `xPlayer.removeAccountMoney(type, amount)`
  - Same fix as `addMoney` for consistency

- **Fixed `FLBridge.getPlayerAccountFunds` for ESX**
  - Maps `cash` to `money` for ESX compatibility
  - Ensures consistent behavior across frameworks

### 📝 ESX Client Events

- **Added duty change handler**
  - `SwitchHandler` now has `dutyChange` handler
  - Fires `filthy_bridge:onDutyChange` event when duty changes

- **Added `flb:updateDuty` event handler**
  - Updates `FLBridge.playerData.job.onduty` when received
  - Triggers `SwitchHandler('dutyChange', isOnDuty)`

### 🔧 Files Modified

- `frameworks/esx/server.lua`
- `frameworks/esx/client.lua`
- `utils/client/helpers.lua`
- `banking/init.lua`
- `config.lua`

### 🐛 Bug Fixes

- **Fixed `FLBridge.isPlayerBoss` for ESX**
  - Removed non-existent `ESX.GetJobGrades()` call
  - Now checks `job.grade_name == 'boss'` directly (like wasabi_bridge)

### 🏦 ESX Society Banking Support

- **Added `esx_society` banking system support**
  - Uses `esx_addonaccount` export `GetSharedAccount` to access society accounts
  - Account name format: `society_<jobname>`
  - Supports `GetSocietyBalance`, `AddSocietyMoney`, and `RemoveSocietyMoney`
  - Requires `esx_society` and `esx_addonaccount` to be running

### 📋 Reference

These changes were inspired by the approach used in:
- **jim_bridge** - ESX duty toggle using `ESX.SetPlayerData("job", tempJob)`
- **wasabi_bridge** - Using `player.addAccountMoney()` / `player.removeAccountMoney()` for ESX


