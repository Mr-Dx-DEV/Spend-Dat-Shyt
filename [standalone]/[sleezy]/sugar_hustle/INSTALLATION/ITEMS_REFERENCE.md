# 📦 Items Reference - Sugar Hustle System

Complete item configurations for all frameworks.

---

## 🎯 QBCore / QBOX

### Location: `qb-core/shared/items.lua` or `qbx-core/shared/items.lua`

```lua
-- SUGAR HUSTLE SYSTEM ITEMS

['sugarphone'] = {
    ['name'] = 'sugarphone',
    ['label'] = 'Sugar Phone',
    ['weight'] = 500,
    ['type'] = 'item',
    ['image'] = 'phone.png',
    ['unique'] = true,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'A special phone for sugar arrangements'
},

['luxury_bag'] = {
    ['name'] = 'luxury_bag',
    ['label'] = 'Luxury Designer Bag',
    ['weight'] = 2000,
    ['type'] = 'item',
    ['image'] = 'luxury_bag.png',
    ['unique'] = true,
    ['useable'] = false,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'An expensive designer handbag'
},

['diamond_necklace'] = {
    ['name'] = 'diamond_necklace',
    ['label'] = 'Diamond Necklace',
    ['weight'] = 500,
    ['type'] = 'item',
    ['image'] = 'diamond_necklace.png',
    ['unique'] = true,
    ['useable'] = false,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'A stunning diamond necklace'
},

['expensive_perfume'] = {
    ['name'] = 'expensive_perfume',
    ['label'] = 'Expensive Perfume',
    ['weight'] = 300,
    ['type'] = 'item',
    ['image'] = 'perfume.png',
    ['unique'] = true,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Luxury French perfume'
},

['gold_watch'] = {
    ['name'] = 'gold_watch',
    ['label'] = 'Gold Watch',
    ['weight'] = 500,
    ['type'] = 'item',
    ['image'] = 'gold_watch.png',
    ['unique'] = true,
    ['useable'] = false,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'An expensive gold timepiece'
},

['designer_shoes'] = {
    ['name'] = 'designer_shoes',
    ['label'] = 'Designer Shoes',
    ['weight'] = 1000,
    ['type'] = 'item',
    ['image'] = 'designer_shoes.png',
    ['unique'] = true,
    ['useable'] = false,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'High-end designer footwear'
},
```

---

## 🎯 ESX

### SQL Database Insert

```sql
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('sugarphone', 'Sugar Phone', 500, 0, 1),
('luxury_bag', 'Luxury Designer Bag', 2000, 1, 1),
('diamond_necklace', 'Diamond Necklace', 500, 1, 1),
('expensive_perfume', 'Expensive Perfume', 300, 1, 1),
('gold_watch', 'Gold Watch', 500, 1, 1),
('designer_shoes', 'Designer Shoes', 1000, 1, 1);
```

``` Add items list to ox inventory ```
--- SUGAR HUSTLE SCRIPT ----
   ["sugarphone"] = {
		label = "Sugar Phone",
		weight = 200,
		stack = false,
		close = true,
	},
    ["luxury_bag"] = {
		label = "Luxury Designer Bag",
		weight = 200,
		stack = true,
		close = true,
	},
    ["diamond_necklace"] = {
		label = "Diamond Necklace",
		weight = 200,
		stack = true,
		close = true,
	},
    ["expensive_perfume"] = {
		label = "Expensive Perfume",
		weight = 200,
		stack = true,
		close = true,
	},
    ["gold_watch"] = {
		label = "Gold Watch",
		weight = 200,
		stack = true,
		close = true,
	},
    ["designer_shoes"] = {
		label = "Designer Shoes",
		weight = 200,
		stack = true,
		close = true,
	},

---

## 🖼️ Item Images

Place images in your inventory's image folder:

### Locations:
- **qb-inventory**: `qb-inventory/html/images/`
- **ox_inventory**: `ox_inventory/web/images/`


### Image Names:
- `phone.png`
- `luxury_bag.png`
- `diamond_necklace.png`
- `perfume.png`
- `gold_watch.png`
- `designer_shoes.png`

**Recommended Size**: 256x256 pixels, PNG format

---

## 🎁 Adding Custom Rewards

Edit `sugar_hustle/config.lua`:

```lua
Config.Rewards = {
    { item = 'luxury_bag', label = 'Luxury Designer Bag', chance = 25 },
    { item = 'your_item', label = 'Your Item', chance = 10 },
}
```

---

**For more details, see README.md or INSTALLATION.md**

