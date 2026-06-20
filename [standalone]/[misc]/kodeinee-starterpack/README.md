# Kodeinee Starter Pack

**By Kodeinee Studios**


## Supported Frameworks

- QBCore
- Qbox
- ESX

## Supported Inventories

- qb-inventory
- ox_inventory
- ESX default inventory

## Dependencies

- oxmysql
- Your framework: `qb-core`, `qbx_core`, or `es_extended`
- Your inventory: `qb-inventory`, `ox_inventory`, or ESX inventory
- Optional: `ox_lib` for better notifications

## Installation

1. Drag the folder into your server resources folder.

2. Rename the folder to:

```cfg
kodeinee-starterpack
```

3. Import this SQL file into your database:

```text
sql/install.sql
```

The script also tries to create the table automatically on resource start, but importing the SQL manually is recommended.

4. Add this to your `server.cfg` after your framework, inventory, and oxmysql:

```cfg
ensure oxmysql
ensure qb-core        # QBCore only
ensure qbx_core       # Qbox only
ensure es_extended    # ESX only
ensure ox_inventory   # If using ox inventory
ensure qb-inventory   # If using qb inventory
ensure kodeinee-starterpack
```

Only ensure the framework and inventory your server actually uses.

## Config Setup

Open `config.lua`.

### Framework

```lua
Config.Framework = 'auto'
```

Options:

```lua
'auto'
'qb'
'qbox'
'esx'
```

Auto detection order:

1. qbx_core
2. qb-core
3. es_extended

### Inventory

```lua
Config.Inventory = 'auto'
```

Options:

```lua
'auto'
'qb'
'ox'
'esx'
```

Auto detection order:

1. ox_inventory
2. qb-inventory
3. ESX inventory

## How Players Use It

Players type:

```text
/starterpack
```

The script checks their character gender and gives the correct pack:

- Male Starter Pack
- Female Starter Pack

If `Config.UseOnce = true`, each character can only claim it one time.

## Editing Starter Items

Edit the item lists inside `config.lua`:

```lua
Config.male_starterpack = {
    label = "Male Starter Pack",
    items = {
        {name = "phone", amount = 1},
        {name = "water", amount = 10},
        {name = "burger", amount = 10},
        {name = "cash", amount = 5000},
        {name = "radio", amount = 1},
    }
}
```

Make sure every item exists in your inventory system.

## Money Handling

Most frameworks do not store cash as an inventory item. This script handles that automatically.

```lua
Config.MoneyItemsAsAccount = true
Config.MoneyAccount = 'cash'
```

When an item is named `cash` or `money`, the bridge adds it as account money instead of an inventory item.

For ESX, `cash` is automatically treated as the ESX `money` account.

## Resetting a Player Claim

To let one player claim again, remove their identifier from:

```sql
kodeinee_starterpack_claims
```

To reset everyone:

```sql
DELETE FROM kodeinee_starterpack_claims;
```

## Files

```text
kodeinee-starterpack/
├── bridge.lua
├── client.lua
├── config.lua
├── fxmanifest.lua
├── server.lua
├── README.md
└── sql/
    └── install.sql
```
