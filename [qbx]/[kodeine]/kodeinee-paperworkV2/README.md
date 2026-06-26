📄 Kodeinee Paperwork V2

By Kodeinee Studios

A fully dynamic, multi-framework paperwork system designed for roleplay servers.
Create, manage, and distribute official records with clean UI, database tracking, and item support.

🚀 Overview

Kodeinee Paperwork V2 allows authorized players (like police or staff) to:

Create official paperwork for ANY player (nearby OR by ID)
Store all data in SQL (persistent across restarts)
Issue physical paperwork items with metadata
View records through commands or UI
Maintain cooldown-based copy distribution

Built for QBCore, Qbox, ESX, and standalone setups with optional inventory integration.

📦 Dependencies
Required
ox_lib
oxmysql
One framework:
QBCore
Qbox
ESX
OR standalone fallback
Optional
ox_inventory
qb-inventory (or similar QB-based inventory)
📥 Installation
1. Add Resource

Place the folder in your server:

resources/[local]/kodeinee-paperworkV2
2. Ensure Order (IMPORTANT)

Add to server.cfg AFTER dependencies:

ensure ox_lib
ensure oxmysql
ensure qb-core (or es_extended / qbx_core)
ensure ox_inventory (optional)

ensure kodeinee-paperworkV2
3. Database Setup

Option A:

Import SQL.sql

Option B:

Just restart server → tables auto-create
4. Item Setup (Optional)

Choose your inventory:

OX Inventory
→ items/ox_inventory_items.lua
QB Inventory
→ items/qb_items.lua

Add items to your shared items file.

5. FULL Restart

Not a refresh — FULL server restart required

🎮 Commands
📝 Paperwork Creation
/setpaperwork
Opens nearby player menu (ox_lib UI)
/setpaperwork [id]
Directly create/edit paperwork using ANY player ID
✅ Works anywhere (perfect for testing/admin use)
📄 Viewing Paperwork
/paperwork
View your own record
/paperwork [id]
View another player’s paperwork
📦 Item Copies
/paperwork item [id]
Gives a physical paperwork item with stored metadata
🧠 How It Works
Step 1 — Create Record

Use:

/setpaperwork [id]

This creates the main database entry.

Step 2 — Store Data

The system saves:

Player Name
Identifier (CitizenID / License)
Status
Notes
Date Issued
Officer Name
Step 3 — Issue Copy (Optional)

Use:

/paperwork item [id]

This gives a usable item with embedded metadata.

⏱️ Cooldown System

To prevent spam:

Config.CopyCooldownHours = 24
Applies per player
Fully configurable in config.lua
🔧 Configuration

Located in:

config.lua
Key Options:
Config.CopyCooldownHours = 24
Config.Framework = 'auto'
Config.Inventory = 'auto'
Supports automatic detection
Or manually set:
'qb'
'esx'
'qbox'
🌐 Framework Compatibility

✔ QBCore
✔ ESX
✔ Qbox
✔ Standalone (limited features)

🎯 Features
📋 Full paperwork system with SQL storage
👮 Police/admin workflow support
🎯 Target ANY player by ID (not just nearby)
📦 Metadata-based item copies
⏱️ Cooldown protection
🧠 Smart framework + inventory detection
🎨 Clean ox_lib UI integration
🔄 Persistent data (never wipes unless DB reset)