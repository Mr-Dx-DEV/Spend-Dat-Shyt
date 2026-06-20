# 💗 grim_lovemenu
**Grim Development** — Love Menu System for FiveM

A production-ready relationship, pregnancy, and health system with a modern iPad-style tablet UI.

---

## Dependencies

| Resource | Notes |
|---|---|
| `ox_lib` | Required — menu/notify/input |
| `oxmysql` | Required — database |
| `ox_inventory` | Recommended — primary inventory |
| `qb-core` **or** `es_extended` | One framework required |

---

## Installation

### 1. Add to resources
```
resources/
  └── grim_lovemenu/
```

**Important:** this package is currently named `grims_lovemenu`. If you previously copied old ox item entries that used `grim_lovemenu.useLoveTablet`, replace them with the updated event-based entries from `shared/items.lua`.

### 2. Run the SQL migration
Import `migration.sql` into your server database (HeidiSQL, phpMyAdmin, etc.)

### 3. Register items

**ox_inventory** — add the following to `ox_inventory/data/items.lua`:
```lua
['love_tablet']       = { label = 'Love Tablet',               weight = 500, stack = false, close = true },
['pregnancy_test']    = { label = 'Pregnancy Test',             weight = 50,  stack = true  },
['contraception']     = { label = 'Contraception',              weight = 50,  stack = true  },
['prenatal_vitamins'] = { label = 'Prenatal Vitamins',          weight = 50,  stack = true  },
['condoms']           = { label = 'Condoms',                    weight = 50,  stack = true  },
['plan_c']            = { label = 'Plan C (Morning-After)',     weight = 50,  stack = false },
['std_test_kit']      = { label = 'STD Test Kit (7 Panel)',     weight = 100, stack = false },
['dna_test']          = { label = 'DNA Test Kit',               weight = 100, stack = false },
['dna_result']        = { label = 'DNA Test Result',            weight = 50,  stack = false },
['birth_cert_boy']    = { label = 'Birth Certificate (Boy)',    weight = 100, stack = false },
['birth_cert_girl']   = { label = 'Birth Certificate (Girl)',   weight = 100, stack = false },
['prescription_meds'] = { label = 'Prescription Medication',    weight = 50,  stack = true  },
['ultrasound_report'] = { label = 'Ultrasound Report',          weight = 50,  stack = false },
```

**QBCore** — add items to `qb-core/shared/items.lua` (same structure, QB format).

### 4. Add item images
Copy your item images to `ox_inventory/web/images/` with these exact filenames:
```
love_tablet.png
pregnancy_test.png
contraception.png
prenatal_vitamins.png
condoms.png
plan_c.png
std_test_kit.png
dna_test.png
dna_result.png
birth_cert_boy.png
birth_cert_girl.png
prescription_meds.png
ultrasound_report.png
```

### 5. Add to server.cfg
```cfg
ensure ox_lib
ensure oxmysql
ensure ox_inventory
ensure grims_lovemenu
```

### 6. QBCore item callback (if not using ox_inventory)
Add to `qb-core/server/main.lua` or a QB items file:
```lua
QBCore.Functions.CreateUseableItem('love_tablet', function(source)
    TriggerClientEvent('grim_lovemenu:item:love_tablet', source)
end)
-- repeat for other items
```

---

## Usage

### Open the tablet
- **Use** the `love_tablet` item from inventory
- **Or** run the command: `/lovemenu`

### Animation workflow
1. Open tablet → **Animations** tab
2. Select a nearby partner (Select Partner)
3. Choose finish mode (Finish / Pull Out)
4. Click an animation — partner receives a 15-second accept prompt
5. Press **X** at any time to cancel

### Pregnancy
- Risk is calculated server-side after each encounter
- Use a **Pregnancy Test** to confirm status
- Take **Prenatal Vitamins** daily to reduce risk
- Request an **Ultrasound** for a report item
- Visit hospital and use **Give Birth** when the due date passes

### STD System
- Unprotected encounters with infected players trigger transmission rolls
- Use the **STD Test Kit** (7-panel) to check status
- Take **Prescription Medication** to cure short-term infections
- HIV, Herpes, HPV are manageable but not curable

### DNA / Paternity
- Open the DNA tab, select a nearby player
- Use a **DNA Test Kit** — results show % likelihood

---

## Config highlights (`shared/config.lua`)

```lua
Config.PregnancyDuration  = 7      -- real-life days until birth

-- Pregnancy risk % by protection type
Config.Risk.pregnancy.unprotected   = 60
Config.Risk.pregnancy.pullout_only  = 20
Config.Risk.pregnancy.contra_only   = 3
Config.Risk.pregnancy.condoms_only  = 5
Config.Risk.pregnancy.both_protected = 1

-- STD risk % by protection type
Config.Risk.std.unprotected         = 40
Config.Risk.std.pullout_only        = 40
Config.Risk.std.contra_only         = 40   -- pill does NOT block STDs
Config.Risk.std.condoms_only        = 5
Config.Risk.std.both_protected      = 2

Config.STDTransmitChance    = 40   -- % base STD transmission (overridden by matrix)
Config.ContraceptionDuration = 72  -- hours of protection per pill use
Config.Debug                = false -- true = clone mode for solo testing
```

---

## File structure
```
grim_lovemenu/
├── fxmanifest.lua
├── migration.sql
├── shared/
│   ├── config.lua      ← all settings + animation table
│   └── items.lua       ← item definitions reference
├── client/
│   ├── cl_bridge.lua   ← framework abstraction
│   ├── cl_main.lua     ← state, item use, command
│   ├── cl_animations.lua ← synced + debug animations
│   ├── cl_tablet.lua   ← NUI bridge
│   ├── cl_pregnancy.lua
│   └── cl_health.lua
├── server/
│   ├── sv_main.lua     ← item router, anim sync, helpers
│   ├── sv_pregnancy.lua
│   └── sv_health.lua   ← STD, contraception, DNA
└── html/
    ├── index.html
    └── assets/
        ├── css/tablet.css
        └── js/
            ├── tablet.js
            └── app.js
```

---

*Made with 💗 by Grim Development — for C2C RP*


## Patch cleanup
- Shared item definitions now include `client.image` entries for all lovemenu items.
- Placeholder PNGs are included in `inventory_images/` — copy those into `ox_inventory/web/images/` if you want instant icons.
- Client tablet partial updates now merge instead of wiping cached state.
- DNA tests now validate active pregnancies in both directions.
- Birth-ready reminders now use a guarded loop and stop when no active pregnancy remains.

- The resource now prints a startup warning if lovemenu items are missing from ox_inventory registration.
- Bank purchases now fall back to framework money removal when no `bank` inventory item exists.
- Coffee/Bro Code ped access is relaxed for custom peds unless `Config.StrictModelGenderApps = true`.
