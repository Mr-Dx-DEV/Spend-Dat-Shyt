# Syringe Sisters — Illegal BBL Shot System

A FiveM resource for crafting, selling, and delivering illegal "BBL Shot" items. Supports **ESX** and **QBCore**, with optional **virtual storage** (no inventory items required). Optional **ox_inventory** item definitions are included for servers that use ox_inventory with ESX/QB.

---

## Table of Contents

1. [Item Lists (QB / ESX / OX)](#item-lists-qb--esx--ox)
2. [Virtual Storage Mode](#virtual-storage-mode)
3. [Dependencies & Setup](#dependencies--setup)
4. [How Everything Works — Step by Step](#how-everything-works--step-by-step)
5. [Commands Reference](#commands-reference)
6. [Configuration Summary](#configuration-summary)

---

## Item Lists (QB / ESX / OX)

Use the lists below to add every item this script uses to your framework’s inventory system.  
**If `Config.UseVirtualStorage = true`**, you do **not** need to add any items; the script stores them internally. Use `/givevirtual`, `/usebbl`, `/delivery`, and `/startrobbery` instead of inventory items.

### All script items (reference)

| Item name         | Label             | Used for                                                                 |
|-------------------|-------------------|--------------------------------------------------------------------------|
| `bbl_shot`        | BBL Shot          | Crafted product; usable (health/stamina boost); sold; delivered; stolen by gangs |
| `medical_silicone`| Medical Silicone  | Crafting ingredient; black market; hospital robbery reward              |
| `syringe`         | Syringe           | Crafting ingredient; black market; hospital robbery reward             |
| `painkillers`     | Painkillers       | Crafting ingredient; black market; hospital robbery reward               |
| `sterile_gauze`   | Sterile Gauze     | Hospital robbery reward only                                            |
| `saline_bag`      | Saline Bag        | Hospital robbery reward only                                            |
| `filler_compound` | Filler Compound   | Hospital robbery reward only                                            |
| `stolen_keycard`  | Stolen Keycard    | Bought at black market; used once to start hospital robbery             |
| `illegal_phone`   | Illegal Phone     | Opens delivery (burner phone) menu; not consumed on use                  |

---

### QBCore (qb-core / qb-inventory)

Add these to your **qb-core** shared item file (e.g. `qb-core/shared/items.lua`) or wherever QBCore items are defined. Adjust `weight` and `description` to match your server.

```lua
-- Syringe Sisters – QBCore items
["bbl_shot"]          = { ["name"] = "bbl_shot",          ["label"] = "BBL Shot",           ["weight"] = 100, ["type"] = "item", ["image"] = "bbl_shot.png",         ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true, ["description"] = "Quick boost." },
["medical_silicone"]  = { ["name"] = "medical_silicone", ["label"] = "Medical Silicone",  ["weight"] = 50,  ["type"] = "item", ["image"] = "medical_silicone.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "Industrial-grade silicone filler." },
["syringe"]           = { ["name"] = "syringe",          ["label"] = "Syringe",           ["weight"] = 20,  ["type"] = "item", ["image"] = "syringe.png",          ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "Sterile injection syringe." },
["painkillers"]       = { ["name"] = "painkillers",      ["label"] = "Painkillers",       ["weight"] = 30,  ["type"] = "item", ["image"] = "painkillers.png",      ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "Strong prescription painkillers." },
["sterile_gauze"]     = { ["name"] = "sterile_gauze",    ["label"] = "Sterile Gauze",     ["weight"] = 40,  ["type"] = "item", ["image"] = "sterile_gauze.png",    ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "Sterile gauze." },
["saline_bag"]        = { ["name"] = "saline_bag",       ["label"] = "Saline Bag",        ["weight"] = 80,  ["type"] = "item", ["image"] = "saline_bag.png",       ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "Saline bag." },
["filler_compound"]   = { ["name"] = "filler_compound", ["label"] = "Filler Compound",  ["weight"] = 60,  ["type"] = "item", ["image"] = "filler_compound.png",  ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "Filler compound." },
["stolen_keycard"]    = { ["name"] = "stolen_keycard",   ["label"] = "Stolen Keycard",    ["weight"] = 10,  ["type"] = "item", ["image"] = "stolen_keycard.png",   ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true, ["description"] = "Hospital access keycard — single use." },
["illegal_phone"]     = { ["name"] = "illegal_phone",   ["label"] = "Illegal Phone",     ["weight"] = 200, ["type"] = "item", ["image"] = "illegal_phone.png",    ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true, ["description"] = "Burner phone for deliveries." },
```

**Note:** The script registers `bbl_shot`, `stolen_keycard`, and `illegal_phone` as **useable** via the framework; you still need them in the item list with `useable = true` so the framework can trigger the use.

---

### ESX (es_extended)

Add these to your **ESX items** table. This is usually in the database (`items` table) or in a shared config (e.g. `es_extended/config.lua` or a dedicated items file). Format depends on your ESX version; below is a typical structure.

**Database (SQL) — if your server uses an `items` table:**

```sql
INSERT INTO `items` (`name`, `label`, `weight`) VALUES
('bbl_shot', 'BBL Shot', 100),
('medical_silicone', 'Medical Silicone', 50),
('syringe', 'Syringe', 20),
('painkillers', 'Painkillers', 30),
('sterile_gauze', 'Sterile Gauze', 40),
('saline_bag', 'Saline Bag', 80),
('filler_compound', 'Filler Compound', 60),
('stolen_keycard', 'Stolen Keycard', 10),
('illegal_phone', 'Illegal Phone', 200);
```

**Config-style (if your ESX uses Lua item definitions):**

```lua
-- Syringe Sisters – ESX items (add to your ESX items config)
Items = {
    { name = "bbl_shot",          label = "BBL Shot",           weight = 100 },
    { name = "medical_silicone",  label = "Medical Silicone",  weight = 50  },
    { name = "syringe",           label = "Syringe",           weight = 20  },
    { name = "painkillers",       label = "Painkillers",       weight = 30  },
    { name = "sterile_gauze",     label = "Sterile Gauze",     weight = 40  },
    { name = "saline_bag",        label = "Saline Bag",        weight = 80  },
    { name = "filler_compound",   label = "Filler Compound",   weight = 60  },
    { name = "stolen_keycard",    label = "Stolen Keycard",    weight = 10  },
    { name = "illegal_phone",     label = "Illegal Phone",     weight = 200 },
}
```

Register **usable** items in ESX so the script can hook them (the resource also registers them on start):

- `bbl_shot` — use triggers BBL Shot effect.
- `stolen_keycard` — use starts hospital robbery (consumes keycard).
- `illegal_phone` — use opens delivery menu (not consumed).

---

### OX (ox_inventory)

If you use **ox_inventory** with ESX or QBCore, add these to `ox_inventory/data/items.lua` (or your override file). The script will still use the framework’s add/remove item API; ox_inventory is the backend that holds the items.

```lua
-- Syringe Sisters – ox_inventory items
['bbl_shot'] = {
    label = 'BBL Shot',
    weight = 100,
    stack = true,
    close = true,
    description = 'Quick boost.',
    client = {
        export = 'syringe_sisters.useBBLShot'  -- optional if script handles via event
    }
},
['medical_silicone'] = {
    label = 'Medical Silicone',
    weight = 50,
    stack = true,
    close = true,
    description = 'Industrial-grade silicone filler.'
},
['syringe'] = {
    label = 'Syringe',
    weight = 20,
    stack = true,
    close = true,
    description = 'Sterile injection syringe.'
},
['painkillers'] = {
    label = 'Painkillers',
    weight = 30,
    stack = true,
    close = true,
    description = 'Strong prescription painkillers.'
},
['sterile_gauze'] = {
    label = 'Sterile Gauze',
    weight = 40,
    stack = true,
    close = true,
    description = 'Sterile gauze.'
},
['saline_bag'] = {
    label = 'Saline Bag',
    weight = 80,
    stack = true,
    close = true,
    description = 'Saline bag.'
},
['filler_compound'] = {
    label = 'Filler Compound',
    weight = 60,
    stack = true,
    close = true,
    description = 'Filler compound.'
},
['stolen_keycard'] = {
    label = 'Stolen Keycard',
    weight = 10,
    stack = true,
    close = true,
    description = 'Hospital access keycard — single use.'
},
['illegal_phone'] = {
    label = 'Illegal Phone',
    weight = 200,
    stack = false,
    close = true,
    description = 'Burner phone for deliveries.'
},
```

**Note:** This resource is written for **ESX** and **QBCore** inventory APIs (`xPlayer.addInventoryItem` / `player.Functions.AddItem`). If your server uses **only** ox_inventory exports (no ESX/QB item API), you would need a bridge or small adapter so the script’s `AddItem`/`RemoveItem`/`GetItemCount` call ox_inventory. The list above gives you all item names and labels for ox_inventory.

---

## Virtual Storage Mode

- **`Config.UseVirtualStorage = true`**  
  All syringe_sisters items are stored in script-only storage (KVP). You do **not** need to add any of the items above to QB/ESX/OX.  
  - Use **`/usebbl`** instead of using the BBL Shot item.  
  - Use **`/delivery`** instead of using the Illegal Phone item.  
  - Use **`/startrobbery`** instead of using the Stolen Keycard item (keycard is still consumed from virtual storage).  
  - Use **`/givevirtual [id] [item] [amount]`** or **`/givevirtual [item] [amount]`** to give virtual items (ACE: `Config.GiveVirtualAce`, e.g. `group.admin`).

- **`Config.UseVirtualStorage = false`**  
  Items are in your real inventory (QB/ESX/ox). You must add every item from the lists above and use the normal inventory items to use BBL Shot, start robbery, or open the delivery menu.

---

## Dependencies & Setup

1. **Framework:** `es_extended` (ESX) **or** `qb-core` (QBCore). Set `Config.Framework = "esx"` or `"qb"` in `config.lua`.
2. **Target:** For the black market ped, **ox_target** or **qb-target**. Set `Config.BlackMarketPed.targetSystem = "ox_target"` or `"qb-target"`.
3. **Optional:** If using virtual storage, no inventory items are required; otherwise ensure all items are in your framework (and ox_inventory if you use it) as in the lists above.

**Installation:**

1. Place the `syringe_sisters` folder in your `resources` directory.
2. Ensure `config.lua`: `Config.Framework`, `Config.UseVirtualStorage`, and (if used) `Config.BlackMarketPed.targetSystem` match your server.
3. Add the items (QB / ESX / OX) as above **unless** you use virtual storage.
4. Add `ensure syringe_sisters` to your `server.cfg`.
5. Restart the server or run `ensure syringe_sisters`.

---

## How Everything Works — Step by Step

### 1. Overview

The script has five main systems:

1. **Crafting** — Craft BBL Shots at a crafting table from ingredients.  
2. **BBL Shot (usable item)** — Use a BBL Shot for health/stamina boost and a short screen effect.  
3. **Black market** — Buy ingredients and a stolen keycard from an NPC.  
4. **Street selling** — Sell BBL Shots to NPCs in defined zones.  
5. **Delivery** — Use the illegal phone to accept a delivery, drive to a drop-off, hand over BBL Shots for higher payment.  
6. **Hospital robbery** — Use a stolen keycard to start a hack at Pillbox; complete a skillcheck to get medical supplies.  
7. **Gang attacks** — Random chance during crafting, street selling, or after delivery to be ambushed; if you die, gang steals some BBL Shots.

---

### 2. Crafting (BBL Shot)

**Where:** At a **crafting table** (prop `tr_prop_meth_table01a`) at positions in `Config.CraftingLocations` (e.g. one near `1274.5, -1720.2, 54.3`).

**Flow:**

1. Player goes near the table; prompt appears: **"E – Craft BBL Shot"**.
2. Script checks **female-only** if `Config.FemaleOnly` is true.
3. Client asks server: **Do I have the ingredients?** (callback `syringe_sisters:checkIngredients`).  
   Recipe in config: **2× Medical Silicone, 1× Syringe, 3× Painkillers** → **1× BBL Shot**.
4. If yes, a **progress bar** runs with a medical animation. Player must stay still; can cancel with Backspace or by moving too far.
5. When the bar finishes, client sends **`syringe_sisters:finishCraft`** with recipe id.
6. Server checks again: near crafting table, gender, ingredients, rate limit, then **removes ingredients** and **adds 1× BBL Shot**.
7. Client gets **`syringe_sisters:craftResult`** (success/fail message). On success, **gang attack** may trigger (see below).

**Ingredients:** Medical Silicone, Syringe, Painkillers (from black market or hospital robbery).

---

### 3. BBL Shot (usable item)

**How it’s triggered:**  
- **Virtual storage:** Player types **`/usebbl`**.  
- **Normal inventory:** Player uses the **bbl_shot** item from inventory (script registers it as usable with the framework).

**Flow:**

1. Server checks cooldown (`Config.BBLShot.Cooldown`), then that the player has at least 1× `bbl_shot`.
2. Server removes 1× `bbl_shot` and triggers client event **`syringe_sisters:useBBLShot`**.
3. Client plays use animation, then applies: **health boost**, **stamina boost**, and a **screen effect** for a few seconds (all from `Config.BBLShot`).

---

### 4. Black market

**Where:** NPC at `Config.BlackMarketPed.coords` (e.g. `25.7, -1346.8, 29.5`). Blip **"Shady Dealer"** if enabled. Interaction via **ox_target** or **qb-target** (“Browse Black Market”).

**Flow:**

1. Player targets the ped and selects “Browse Black Market”.
2. NUI menu opens (`html/index.html`) listing items from `Config.BlackMarketPed.items`:  
   Medical Silicone, Syringe, Painkillers, **Stolen Keycard** (prices and max per purchase in config).
3. Player selects item and quantity, confirms. Client sends **`blackmarket:purchase`** NUI callback.
4. Server callback **`syringe_sisters:blackmarket:purchase`** checks: item in config, amount ≤ max, player has enough cash/bank (config: `moneyType`), then **removes money** and **adds item** via framework (or virtual storage).

Money type (cash/bank) is set in `Config.BlackMarketPed.moneyType`.

---

### 5. Street selling

**Commands:** **`/sellbbl`** start, **`/cancelsell`** stop, **`/sellblips`** toggle zone blips.

**Where:** Player must be inside one of **`Config.StreetSellZones`** (radius zones). Optional blips for zones via **`/sellblips`**.

**Flow:**

1. Player types **`/sellbbl`**. Client asks server **`syringe_sisters:streetSell:canStart`**: female (if required), not already selling, police count ≥ `Config.PoliceRequired`, has ≥ 1× BBL Shot, cooldown. If OK, server sets player as “actively selling”.
2. Client loop: while in a sell zone and selling, every **NpcIntervalMin–NpcIntervalMax** seconds a **buyer NPC** spawns, walks to the player, and when close the client notifies “A buyer is approaching...” and runs hand-off animation.
3. After animation, client fires **`syringe_sisters:streetSell:transaction`**.
4. Server: rate limit, must be in active sell session, has ≥ 1× BBL Shot. Server **removes 1× bbl_shot** and **adds cash/bank** (random between `PriceMin` and `PriceMax`). Optional **police alert** (chance `PoliceChance`). Client is notified; **gang attack** can trigger.
5. If player leaves the zone, selling stops. After stopping, **cooldown** (e.g. 300s) before `/sellbbl` again.

---

### 6. Delivery (illegal phone)

**How it’s triggered:**  
- **Virtual storage:** **`/delivery`**.  
- **Normal inventory:** Use **illegal_phone** item (script registers it).

**Flow:**

1. Server opens the delivery menu for the player (client event **`syringe_sisters:delivery:openMenu`**).
2. Client shows an in-world **phone menu**: “Start Delivery” / “Cancel Delivery” / “Close”. Navigate with UP/DOWN, ENTER to select, BACKSPACE to close.
3. **Start Delivery:** Client calls **`syringe_sisters:delivery:canStart`**. Server checks: female (if required), no active delivery, cooldown, then **random shot count** (e.g. 2–5) and **enough bbl_shot**. Server picks a **random drop-off** from `Config.Delivery.DropLocations`, stores active delivery (shot count, drop coords), and returns success + drop coords + shot count.
4. Client creates a **blip** to the drop, and a **timeout** (e.g. 90s) to reach it. Player drives to the drop.
5. At the drop, a **receiver NPC** spawns. Player gets close; client runs hand-off animation, then sends **`syringe_sisters:delivery:complete`**.
6. Server: checks player at drop, still has enough bbl_shot, **removes bbl_shot** (shot count), **adds payment** (scaled by shot count and config prices). Optional police alert. Clears active delivery. Client removes blip and notifies; **gang attack** may trigger.
7. **Cancel:** Player chooses “Cancel Delivery” in the phone menu. Server applies **CancelPenalty** cooldown and clears active delivery.

---

### 7. Hospital robbery

**How it’s triggered:**  
- **Virtual storage:** **`/startrobbery`** (consumes 1 virtual keycard).  
- **Normal inventory:** Use **stolen_keycard** item (consumes 1).

**Flow:**

1. Server **UseKeycard**: checks no robbery in progress, **global cooldown** (e.g. 30 min), **police count** ≥ `Config.Robbery.PoliceRequired`, player has **stolen_keycard**. Then **removes 1× stolen_keycard** and sets robbery in progress for this player; triggers client **`syringe_sisters:robbery:start`**.
2. Client: creates **robbery blip** to Pillbox cabinet (`Config.Robbery.Location`), sets stage to **travel**. Player must go to the cabinet.
3. At cabinet, player is prompted to hack. Client runs a **skillcheck** (e.g. 4 rounds, press SPACE in the green zone). If **success**: client notifies “Cabinet cracked! Grab the supplies!” and sends **`syringe_sisters:robbery:success`**. If **fail**: client notifies “Hack failed! Alarm triggered!” and sends **`syringe_sisters:robbery:fail`**.
4. **Success:** Server spawns **security guards** (config), gives **rewards**: random 2–4 types from **RewardPool** (medical_silicone, painkillers, syringe, sterile_gauze, saline_bag, filler_compound) with random min–max amounts. Rewards are tracked for a short **disconnect rollback** window. Client gets **`syringe_sisters:robbery:rewardNotify`** with summary.
5. **Fail:** Server triggers **police alert** (blip + message to all police). Global cooldown is set.
6. If the player **dies** during robbery (any stage), server clears their robbery state. Rewards given in the last 60 seconds can be rolled back on disconnect.

---

### 8. Gang attacks

**When:** After **successful crafting**, or during **street selling** (after a sale), or after **completed delivery**. Each trigger has a **chance** (`Config.GangAttackChance`, e.g. 0.15); which activities can trigger is in `Config.GangAttack.Triggers`.

**Flow:**

1. Client **TryGangAttack(activity)** checks cooldown and random chance, then spawns **hostile peds** (config: models, weapons, count, distance). They are in relationship group **SYRINGE_GANG** (hostile to player).
2. If the **player dies** during the attack, server event **`syringe_sisters:gang:playerDied`** runs: **removes** a random amount of **bbl_shot** (StealAmountMin–StealAmountMax) from the player and notifies them. Peds despawn after a timeout if the player survives.

---

## Commands Reference

| Command | Who | Description |
|--------|-----|-------------|
| `/usebbl` | All (or virtual only) | Use one BBL Shot (when virtual storage is on). |
| `/delivery` | All (or virtual only) | Open delivery phone menu (when virtual storage is on). |
| `/startrobbery` | All (or virtual only) | Start hospital robbery, consumes one keycard (when virtual storage is on). |
| `/sellbbl` | Players | Start street selling in a sell zone. |
| `/cancelsell` | Players | Stop street selling. |
| `/sellblips` | Players | Toggle sell-zone blips on the map. |
| `/givevirtual [id] [item] [amount]` | Admin (ACE) | Give virtual items to player `id`. |
| `/givevirtual [item] [amount]` | Admin (ACE) | Give virtual items to yourself. |

Valid **item** names for `/givevirtual`:  
`bbl_shot`, `medical_silicone`, `syringe`, `painkillers`, `sterile_gauze`, `saline_bag`, `filler_compound`, `stolen_keycard`, `illegal_phone`.

---

## Configuration Summary

- **`config.lua`** controls:
  - **Framework** (esx / qb) and **UseVirtualStorage**.
  - **FemaleOnly**, **PoliceRequired**, **GangAttackChance**.
  - **BBLShot**: health/stamina/effect/anim/cooldown.
  - **CraftingLocations**, **Recipes** (ingredients and result).
  - **StreetSellZones**, **StreetSelling** (prices, police chance, commands, blips).
  - **BlackMarketPed** (coords, target system, items and prices).
  - **Robbery** (location, cooldown, police required, skillcheck, guards, reward pool, police alert).
  - **Delivery** (phone item, shot count range, payment, cooldowns, drop locations, police chance).
  - **GangAttack** (chance, triggers, peds, weapons, steal item and amount).

For exact values and optional features (e.g. police alerts, blips), see **`config.lua`** in the resource.
