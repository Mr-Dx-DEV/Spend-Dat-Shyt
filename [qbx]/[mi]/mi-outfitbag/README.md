# Outfit Bag Script (mi-outfitbag)

A simple script to place a bag, save your current outfit into it, and change back into it later.

## Installation

1. Drag and drop `mi-outfitbag` into your resources folder.
2. Add `start mi-outfitbag` to your `server.cfg`.

## Item Setup

You need to add the item `outfitbag` to your inventory system.

**For QBCore (Shared Items):**
Add this to `qb-core/shared/items.lua`:

```lua
['outfitbag'] = {['name'] = 'outfitbag', ['label'] = 'Outfit Bag', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'outfitbag.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A bag to carry your outfit.'},
['outfitbag_small'] = {['name'] = 'outfitbag_small', ['label'] = 'Small Outfit Bag', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'outfitbag.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A small bag to carry your outfits (3 slots).'},
['outfitbag_med'] = {['name'] = 'outfitbag_med', ['label'] = 'Medium Outfit Bag', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'outfitbag.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A medium bag to carry your outfits (6 slots).'},
['outfitbag_big'] = {['name'] = 'outfitbag_big', ['label'] = 'Large Outfit Bag', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'outfitbag.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A large bag to carry your outfits (10 slots).'},
```


**For Ox Inventory:**
Add to `ox_inventory/data/items.lua`:

```lua
['outfitbag'] = {
    label = 'Outfit Bag',
    weight = 1000,
    stack = false,
    close = true,
    description = 'A bag to store an outfit'
},
['outfitbag_small'] = {
    label = 'Small Outfit Bag',
    weight = 1000,
    stack = false,
    close = true,
    description = 'A small bag to store outfits (3 Slots)'
},
['outfitbag_med'] = {
    label = 'Medium Outfit Bag',
    weight = 1000,
    stack = false,
    close = true,
    description = 'A medium bag to store outfits (6 Slots)'
},
['outfitbag_big'] = {
    label = 'Large Outfit Bag',
    weight = 1000,
    stack = false,
    close = true,
    description = 'A large bag to store outfits (10 Slots)'
},
```

## Dependencies
- `ox_lib`
- `ox_target` or `qb-target` (only if `Config.Interaction` uses target; drawtext needs none)
- `qb-core` or `qbx_core` or `es_extended` (only if you want usable item integration and jobs )
- `oxmysql` or `ghmattimysql` (only required if you enable database storage)

## Storage modes

By default the outfit bag reads and writes its saved outfits directly on the inventory item (`item.info`/`item.metadata`). If you want the data to live inside your SQL database instead (useful for inventories that cannot persist metadata), flip the storage mode in `config.lua`:

```lua
Config.Storage = {
    mode = 'database', -- 'metadata' (default) or 'database'
    database = {
        table = 'mi_outfitbag_data'
    }
}
```

When `mode` is set to `database`, the first available MySQL driver (`oxmysql` or `ghmattimysql`) will be used and the table above is created automatically when the resource starts (if the database user has enough privileges). Each bag keeps a stable `bagId` inside its metadata so the same row can be fetched the next time the player places it.

If auto-creation is blocked by permissions you can manually create the table once with:

```sql
CREATE TABLE IF NOT EXISTS `mi_outfitbag_data` (
  `bag_id` VARCHAR(128) NOT NULL PRIMARY KEY,
  `player_id` VARCHAR(64),
  `outfits` LONGTEXT,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

Once the database is enabled, the bag still hands a normal item back to the player, but its metadata now carries both `outfits` and the persistent `bagId` so your table can track the latest state.
