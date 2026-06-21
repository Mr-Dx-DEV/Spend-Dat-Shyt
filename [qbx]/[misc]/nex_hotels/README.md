# nex_hotels

A complete, framework-agnostic hotel system for FiveM. Players walk up to a
front-desk ped, rent a room for a configurable number of days, get a personal
GPS marker to their door, lock and unlock with a single key press, and use
in-room storage / safe / wardrobe / minibar — all of it owned by their
character (citizenid), surviving server restarts, character switches, and
disconnects.

Admins manage hotels through a clean in-game UI (`/hoteladmin`) with an
in-game door picker, coordinate copy from your current position, and live
sync to every connected player.

---

## Features

- **Multi-framework** — works on Qbox, qbcore, ESX, and standalone Ox Core
- **Per-character ownership** — rentals are tied to the character (citizenid /
  charid / identifier), not the account, so each character has their own room
- **Multi-hotel rentals** — a character can rent across many hotels at once, and
  hold several rooms in the same hotel (configurable via `Config.RentLimits`)
- **Day-based rentals** with player-driven extend, automatic eviction sweep, and
  refundable currency
- **Pays from bank OR cash** — script tries the configured account first, falls
  back to the other, and refuses if neither covers the price
- **Recovery locker** — anything left in the room when a rental ends is moved
  into a personal recovery stash the player can claim later from any front desk
- **Custom admin UI** with door picker (highlight a real door prop in the
  world), coord pickers, room CRUD, elevator stops, and blip + ped editors
- **Custom rent UI** with floor pills, room grid showing availability, day
  picker, extend modal, recovery + checkout
- **Floating keycap door prompt** — world-anchored `[E]` keycap on the door
  itself, red when locked, green when unlocked
- **Native door system** — uses GTA's `AddDoorToSystem`, supports single and
  double doors
- **GPS marker + cone** to your door, auto-disappears after the first interaction
- **In-room interactions** (storage / safe / wardrobe / minibar) configurable
  between TextUI and ox_target via a single config flag
- **Bundled SQL imports** for three popular interiors (Opium Nights, Richards
  Cortez Motel, V Hotel) — drop-in for customers who own those MLOs/IPLs
- **JSON locales** — all notifications, prompts and the rent UI read from
  `locales/<code>.json`. Ships with English + Spanish; add a language by copying
  `locales/en.json`, translating it, and pointing `Config.Locale` at it

---

## Requirements

### Required

| Resource | Why |
|----------|-----|
| **oxmysql** | Database persistence |
| **ox_lib** | Notifications, callbacks, NUI helpers |
| **ox_inventory** | Room stash / safe / minibar shop |
| A framework: **Qbox** *or* **qbcore** *or* **ESX** *or* **Ox Core** | Player identity and money |

### Optional

| Resource | Why |
|----------|-----|
| `ox_target` | Eye-tracking interactions instead of TextUI prompts (toggle in `config.lua`) |
| Specific MLO/IPL add-ons | Required only if you import the bundled hotels — see `imports/README.md` |

### Server software

- Any recent FiveM artifact build with `lua54` support
- MySQL 5.7+ or MariaDB 10.2+

---

## Installation

### 1. Drop in resources

Place `nex_hotels` anywhere under `resources/`. We recommend a category folder:

```
resources/[nex]/nex_hotels/
```

### 2. Add to `server.cfg`

Make sure your dependencies start first:

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory
ensure ox_target          # optional — only if you set Config.Interact = 'target'
ensure qbx_core           # or qb-core, es_extended, ox_core
ensure nex_hotels
```

### 3. Configure `config.lua`

Open `nex_hotels/config.lua` and set at minimum:

- `Config.Framework` — `'qbox'` / `'qbcore'` / `'esx'` / `'ox'`
- `Config.AdminGroups` — Ace groups allowed to run `/hoteladmin` (default `{ 'admin' }`)
- `Config.Interact` — `'textui'` (default) or `'target'`
- `Config.PaymentAccount` — `'bank'` (default) or `'cash'` — the **first**
  account the script tries to charge from. The other is the automatic fallback.
- `Config.Theme.AccentColor` — recolors the whole UI. The panels are a black +
  single-accent design; set this to any hex (`'#E11D48'`, `'#0EA5E9'`) or
  `'R,G,B'` triplet and every accent (headings, buttons, highlights, borders,
  glows) recolors to match. Text sitting on the accent auto-switches between
  black/white so it stays readable on any color. Default `'#FFFFFF'` (white).

Everything else has sensible defaults.

### 4. First boot

Start the resource. Watch your server console:

```
[nex_hotels] Boot: installing schema…
[nex_hotels] ┌──────────────────────────────────────────────────────────┐
[nex_hotels] │  DATABASE SCHEMA CHECK                                     │
[nex_hotels] └──────────────────────────────────────────────────────────┘
[nex_hotels]  [ OK ] nex_hotels                 23/23 columns
[nex_hotels]  [ OK ] nex_hotel_rooms            29/29 columns
[nex_hotels]  [ OK ] nex_hotel_elevators         3/3  columns
[nex_hotels]  [ OK ] nex_hotel_elevator_stops    8/8  columns
[nex_hotels]  [ OK ] nex_hotel_rentals           5/5  columns
[nex_hotels]  [ OK ] nex_hotel_room_keys         6/6  columns
[nex_hotels]  Result: PASS — every table and column is present.
[nex_hotels] Boot: loading hotels from DB…
[nex_hotels] Boot: DB is empty.
[nex_hotels]   - To seed bundled MLOs/IPLs: run a file from the imports/ folder against your DB, OR
[nex_hotels]   - Use /hoteladmin in-game to create hotels manually.
[nex_hotels] Boot: complete. Initial sync broadcast.
```

The tables are **auto-injected on first boot** — no manual SQL needed. On every
start the script runs a **DB schema check** that creates any missing table,
column, or index and prints the report above. If anything is ever off, an admin
can re-run it live with `/hotelschemacheck` (no restart needed).

### 5. Add hotels (pick one)

**Option A — bundled imports** (fastest if you own one of the supported MLOs):

```bash
mysql -u <user> -p <db> < resources/[nex]/nex_hotels/imports/01_opium_nights_hotel.sql
```

See [`imports/README.md`](imports/README.md) for the full list and prerequisites.

**Option B — build your own in-game** (no MLO required, works with any interior):

1. Stand at the location you want for the front desk
2. Run `/hoteladmin` (admin only)
3. Click **+ New Hotel**, fill in name + entrance + exit + ped + blip
4. Open the hotel, switch to the **Rooms** tab
5. Click **+ Add Room** — use the door picker to highlight a real prop in the
   world, copy your current coords for entry / interior / storage / safe /
   wardrobe / minibar

Players see new hotels and rooms instantly — no restart needed.

### 6. Images (hotel & room photos)

Two optional image URLs per hotel — set them in `/hoteladmin` → open the hotel →
**Details** tab → **Description** section (or the `image` / `room_image` columns
if you edit the DB directly):

| Field | Where it shows | Recommended size |
|---|---|---|
| **Hotel image** | The big banner behind the hotel name in the admin panel **and** the player's front-desk (rent) screen, plus a small thumbnail in the sidebar | **1280 × 720** (16:9) |
| **Room image** | The per-hotel default room photo | **1280 × 720** (16:9) |

**Sizing tips**

- **Use a landscape 16:9 image, ~1280 × 720.** Anything from ~1024 px up to
  1920 × 1080 looks crisp; bigger than that is just wasted bandwidth.
- The banner is displayed **cropped to fill** a wide, short strip (the image is
  scaled and center-cropped, not squished), so **keep the main subject roughly
  centred** — the top and bottom edges get trimmed.
- The sidebar thumbnail is auto-downscaled from the same hotel image, so you
  **don't** need a separate small version.

**URL requirements**

- Must be a **direct, public image link** ending in `.png`, `.jpg`, `.jpeg`, or
  `.webp` (e.g. `https://i.imgur.com/abc123.png`) — a link to a gallery *page*
  won't load. **HTTPS** is recommended.
- The game client fetches it at runtime, so it has to be reachable from players'
  machines (a public host / CDN, not `localhost`).
- Keep it reasonable — **under ~1–2 MB** — so it loads quickly. Leave a field
  blank to fall back to a clean accent gradient.

---

## Configuration reference

All options live in `config.lua` with inline comments. Highlights:

| Key | Default | Notes |
|---|---|---|
| `Config.Framework` | `'qbox'` | One of `qbox`, `qbcore`, `esx`, `ox` |
| `Config.Locale` | `'en'` | Language for notifications, prompts and the rent UI. Maps to `locales/<code>.json`. Ships with `en` + `es`; add your own by copying `locales/en.json`. Missing keys fall back to English |
| `Config.Debug` | `false` | Draws ox_target zone outlines and prints extra logs |
| `Config.Interact` | `'textui'` | `'textui'` or `'target'` — applies to **front desks, elevators, in-room items**. Doors always use the floating [E] keycap regardless |
| `Config.InteractKey` | `38` (E) | Key code for textui interactions |
| `Config.InteractDistance` | `1.8` | World units |
| `Config.FadeDuration` | `600` | ms — screen fade on teleports |
| `Config.PaymentAccount` | `'bank'` | Primary; the other is the automatic fallback |
| `Config.Rent.MinDays` | `1` | Minimum stay |
| `Config.Rent.MaxDays` | `30` | Cap per transaction; players can extend repeatedly |
| `Config.Rent.SweepIntervalMs` | `60000` | How often expired rentals are evicted |
| `Config.RentLimits.PerHotel` | `1` | Max rooms one character can rent in a single hotel (`1` = classic one-per-hotel; raise to allow several) |
| `Config.RentLimits.Total` | `0` | Max rooms across all hotels combined; `0` = unlimited |
| `Config.StashCapacity.storage` | `{ slots = 50, weight = 100000 }` | Room storage closet size (`weight` in grams; 100000 = 100 kg) |
| `Config.StashCapacity.safe` | `{ slots = 10, weight = 25000 }` | In-room safe size |
| `Config.StashCapacity.recovery` | `{ slots = 100, weight = 200000 }` | Per-character recovery locker size |
| `Config.HotelOwnership` | `false` | Future feature — hotel purchase + passive income (UI hidden when off) |
| `Config.Minibar` | water + sandwich | Per-room minibar stock; `name` must match items in your `ox_inventory/data/items.lua` |
| `Config.AdminGroups` | `{ 'admin' }` | Ace groups for `/hoteladmin`. Each becomes `group.<name>` (e.g. `group.admin`) — also honors framework admin groups (qbox/qbcore admin/god, esx admin/superadmin) |

---

## Commands

| Command | Who | Purpose |
|---|---|---|
| `/hoteladmin` | Ace `group.admin` (or whatever you set) | Opens the admin UI |

---

## How players use it

1. Open the map → look for the hotel blip (color/sprite configurable per hotel)
2. Walk up to the front desk → press **E** (or eye-target it)
3. The rent UI opens: pick a floor, pick a room, pick days, click **Rent**
4. A GPS route + cone marker leads them to their room door
5. Press **E** at the door — keycap toggles red ↔ green to lock/unlock
6. Inside, press **E** at storage / safe / wardrobe / minibar (or eye-target them)
7. To extend: walk back to the front desk → click **Extend** in the modal
8. To check out: front desk → **Check Out**. The room is freed instantly; any
   items left behind go into their **Recovery Locker**, claimable from any
   front desk

Rentals persist across server restarts and character switches. If time
expires while a player is offline, the system evicts them on the next sweep
and moves any stash items into recovery.

---

## Permissions

`/hoteladmin` is gated by FiveM Ace permissions **and** your framework's
admin group, in either of two ways:

```cfg
# Native ace (recommended)
add_principal identifier.steam:110000123456789 group.admin
```

…or be in your framework's admin group (qbox/qbcore `admin` or `god`, ESX
`admin` / `superadmin`). Ox Core uses Ace exclusively.

---

## Troubleshooting

**"My hotel/room doesn't show up after I created it"**

Check the F8 console for an error. The most common cause is a mismatched
`Config.Framework` — if the bridge can't resolve player identifiers, the
client never receives the sync event.

**"Players fall through the map when entering a room"**

The MLO or IPL for that hotel isn't streamed by your server. Bundled imports
list their prerequisites in `imports/README.md`. For your own hotels, make
sure you stand inside the interior in-game before copying interior coords.

**"Door doesn't lock — it just opens normally"**

The door object name in the room editor must exactly match the `archetype`
of a real door prop in the world. Use the door picker (left-click while it's
active) to highlight the prop and the name auto-fills.

**"Money is being charged but the rental doesn't activate"**

Almost always a framework misconfiguration. Make sure `Config.Framework`
matches your actual core resource and that `nex_hotels` starts **after** the
core resource in `server.cfg`.

**"`Table 'xxx.nex_hotels' doesn't exist`" / "Unknown column" on boot**

The schema check repairs this automatically — it creates any missing table or
column on startup. If you still see it, your DB user may lack `CREATE`/`ALTER`
privileges, or oxmysql is pointed at the wrong database. Confirm the connection
string, then run `/hotelschemacheck` in-game (admin) to re-run the check and
read the per-table report in the server console.

**"Bundled SQL import fails with `Duplicate entry` on the unique name key"**

The hotel already exists. The import files use `ON DUPLICATE KEY UPDATE` so
this should be safe — but only if you're running a recent MySQL/MariaDB
version. Update your DB engine, or `DELETE FROM nex_hotels WHERE name = 'X'`
and re-import.

**"Recovery locker is empty even though I had stuff in the room"**

ox_inventory's stash transfer is asynchronous — items appear within a second
or two of checkout. If they never arrive, check your `ox_inventory` log for
stash registration errors.

---

## Support

Open a support ticket in the store you purchased from with:

- Your `Config.Framework` value
- Your FiveM artifact build number
- Whether the issue is on a fresh install or after a config change
- Server console output around the time of the issue (the `[nex_hotels]` lines)

---

## License

Per-server license. Do not redistribute.
