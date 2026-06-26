# Orbit OnlyPics

**Author:** Orbit Scripts
**Version:** 2.0.3
**Description:** A female-only photo career with ranks, XP, challenges, achievements, and viral events for GTA V RP servers.

## Documentation

For more information and advanced configuration, visit the official docs:
https://docs.orbitscripts.xyz

## What's New in v2

v2 is a major expansion over v1, turning the original photo-selling job into a full career progression system.

- **10 Ranks** — From *Rookie* to *Legend*, each unlocks higher payouts (1.00× → 1.80×) and larger bundles (3 → 10 photos)
- **XP System** — Earn XP from sales, premium reactions, and first-time location discoveries
- **5 Photo Locations** — Hotspot bonuses from 1.15× up to 2.00×, stacking with rank multipliers (Vinewood Sign, Del Perro Pier, Maze Bank Rooftop, Galaxy Nightclub, Luxury Yacht)
- **Daily + Weekly Challenges** — Rotating goals with auto-paid cash and XP rewards
- **10 Permanent Achievements** — Milestones including First Flash, Going Viral, World Tour, Millionaire Club, Legendary
- **Viral Photo Events** — Per-photo capture-time rolls mark items as viral; viral photos sell for 8× payouts
- **Follower System** — Gained on sales, lost on rejections and steals
- **Personal Stats Panel** (`/baddiestats`) — XP bar, rank progress, lifetime stats
- **Rebuilt Leaderboard** — Rank badges alongside top earners
- **Smarter NPC Spawning** — Buyers no longer spawn on rooftops or inside buildings
- **Player-to-Player Photo Trading** — Third-eye any online player to offer them a photo or bundle; buyer sees a blurred preview popup with the price and Accept/Decline buttons, fully server-validated
- **5 Photo Type Presets** — Face, Chest, Full Body, Rear, and Feet framings that auto-reposition the selfie cam and aim at the right body part, cycled with `[↓]` in the settings submenu
- **Zoom & Vertical Camera Control** — Scroll-wheel zoom (15°–115° FOV) and `[← →]` arrow vertical adjustment in selfie mode, with smooth lerped transitions
- **Camera Settings Submenu** — Zoom, height and photo type tucked behind a clean `[G] Camera Settings` submenu so the main HUD stays uncluttered
- **Female-Only Boosted Zone Blips** — Hotspot map blips only appear for players using the female model, reacting to character switches and respawns

All v1 features (camera system, photo bundles, thief NPCs, leaderboard, framework/inventory compatibility) are preserved.

## Features

- Works with all frameworks (ESX, QBCore, QBox) — change one setting in config
- Works with all major inventory systems (ox_inventory, qb-inventory, qs-inventory, lj-inventory, esx_inventoryhud)
- Multiple UI systems supported (ox_lib, ESX, QB, custom)
- Multiple notification systems (ox_lib, ESX, QB, custom)
- Configurable camera, prices, ranks, locations, challenges, and achievements via `shared/config.lua`
- Drag-and-drop installation with automatic v1 → v2 database migration
- Female-only system with camera shop, pose system, and photo selling
- Photo Bundles — take multiple photos in one session and sell them as a bundle
- Bundle Viewer — scroll through bundle photos with arrow navigation
- Leaderboard system — track top earners with a configurable command
- Thief NPC mechanic — buyers can steal your photo; chase them down and loot them back
- Lightweight and optimized for server performance

## Installation

1. Drag the `orbit-onlypics` folder into your server `resources` folder.
2. Add the following line to your `server.cfg`:

```
ensure orbit-onlypics
```

3. **Go into the `install` folder and:**
   - Run `database.sql` in your database
   - Choose your framework setup file:
     - `esx_setup.lua` for ESX
     - `ox_inventory_setup.lua` for OX Inventory
     - `qbcore_setup.lua` for QBCore
     - `qbox_setup.lua` for QBox
   - Follow the instructions in the setup file
   - Add the required images to your inventory system

4. Edit `shared/config.lua` to set your framework, inventory, and preferences
5. Restart your server

All installation files are located in the `install` folder.

> ⚠️ **Using `screencapture`?**
> If your server runs the [screencapture](https://github.com/itschip/screencapture) resource, it will hijack `screenshot-basic`'s client exports and break photo capture in this script.
> To fix this, make sure `screenshot-basic` and `orbit-onlypics` are started **before** `screencapture` in your `server.cfg`:
> ```
> ensure screenshot-basic
> ensure orbit-onlypics
> ensure screencapture   # must come AFTER the two above
> ```

## Upgrading from v1.x

1. **Stop your server**
2. Replace your old `orbit-onlypics/` folder with the v2 one
3. Keep your existing customizations in `shared/config.lua` — v2 is fully additive, no renamed or removed keys
4. Start your server. v2 will **auto-migrate** your existing `baddie_stats` table and create the 3 new tables (`baddie_challenges`, `baddie_achievements`, `baddie_locations`) on boot
5. (Optional) Run `install/database.sql` manually if auto-migration fails — it's safe to run on existing v1 installs

## Player Commands

| Command | What it does |
|---------|--------------|
| `/onlypics` | Start a photo sale — summons an NPC buyer |
| `/topbaddies` | Open the leaderboard |
| `/baddiestats` | View your rank, XP, followers, earnings |
| `/baddiegoals` | View active daily + weekly challenges |
| `/baddieawards` | View achievement grid (locked + unlocked) |

## Support

- **Discord:** https://discord.gg/orbitscripts
- **Documentation:** https://docs.orbitscripts.xyz
---

## 📱 Baddie Phone (v2.0.2)

A second, separate item — **`baddie_phone`** — that opens a phone in the corner of
the screen with the **OnlyPics** app permanently on it. This is *not* the
real-world camera (`baddie_cam`); it's its own self-contained social loop:

1. **Create an account** right in the app (username, display name, password).
2. **Take photos** in the Camera tab — frame the selfie in-world, press **Enter**
   to snap. Shots save straight to your **Gallery**.
3. **Upload** a gallery photo to post it. Posted photos passively earn over time.

### Passive earnings (every 15 min, per uploaded photo)
- **Views** — `5–20` for normal photos, `50–100` for viral (high rolls are rarer).
- **Likes** — about a third of that interval's views.
- **Followers** — roughly `0.45 ×` views, added to your page.
- **Donations** — a slice of viewers tip you `$2,000–3,000` (normal) /
  `$3,000–5,000` (viral), paid to cash or bank.
- Normal photos stop earning after a random **12–24h**; viral photos last **24–48h**.
- A photo has a configurable **% chance to go viral** the moment it's uploaded.

Everything above lives under `Config.BaddiePhone` (frame position/size, the item
name, gallery cap, and the full `Growth` economy). By default earnings only
accrue while you're online — flip `Growth.OfflineEarnings` to change that.

### Install
The `baddie_phone` item is already included in every install file
(`install/ox_inventory_setup.lua`, `qbcore_setup.lua`, `qbox_setup.lua`,
`esx_setup.lua`) and the two new tables are in `install/database.sql`
(`baddie_phone_accounts`, `baddie_phone_photos`). Re-run `database.sql` and add
the item, then `/baddiephone` (or use the item) opens it.
