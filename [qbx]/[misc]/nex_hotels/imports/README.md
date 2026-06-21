# nex_hotels — MLO / IPL imports

Pre-built SQL files that drop a fully-configured hotel into your database in one
command. Each file is self-contained, idempotent, and matches a specific GTA V
interior. Pick the ones whose interiors you actually have streamed on your
server, and skip the rest — you don't need every file.

---

## Files

| File | Hotel | Type | Floors | Rooms | Prerequisite |
|------|-------|------|-------:|------:|--------------|
| `01_opium_nights_hotel.sql` | Opium Nights Hotel | IPL | 6 | 78 | The `johanni_opium_*` IPL set (loaded automatically by `nex_hotels` per occupied floor) |
| `02_richards_cortez_motel.sql` | Richards Cortez Motel | MLO | 2 | 24 | Richards Hotel Cortez MLO add-on |
| `03_v_hotel.sql` | V Hotel | MLO | 1 | 3 | V Hotel / Vinewood V Hotel MLO add-on |

> **Make sure your server actually streams the matching MLO/IPL before importing
> the SQL** — if the interior doesn't exist in the world, players will fall
> through the map when they enter a room. The SQL only sets up the database
> rows; it does not stream geometry.

---

## How to run

### Option 1 — phpMyAdmin / HeidiSQL / DBeaver

1. Open your FiveM server's database in your SQL client.
2. Open the `.sql` file you want to import.
3. Execute it. You'll see one row added to `nex_hotels` and N rows added to
   `nex_hotel_rooms`.
4. Restart the `nex_hotels` resource (or run `refresh` then `restart nex_hotels`
   in the server console). The new hotel appears immediately in `/hoteladmin`
   and at the front desk in-game.

### Option 2 — command line (mysql client)

```bash
mysql -u <user> -p <database_name> < imports/01_opium_nights_hotel.sql
```

### Option 3 — txAdmin Database recipe

Drop the file into your recipe and txAdmin will execute it during deploy.

---

## Idempotency

Every file uses `INSERT ... ON DUPLICATE KEY UPDATE`, so running the same
import twice will **not** create duplicates:

- The `nex_hotels` row is matched by its unique `name`. Re-running updates the
  description / coords / blip / ped to whatever the file specifies.
- Each `nex_hotel_rooms` row is matched by `(hotel_id, floor_number, room_number)`.
  Re-running updates that room's coords / price / door object — but does **not**
  create a duplicate row.
- Active rentals in `nex_hotel_rentals` are NOT touched by these files. You
  won't kick anyone out of a room by re-importing.

This means you can use these files as the canonical source-of-truth for an MLO
and re-apply them after schema migrations, fresh installs, or when moving
servers.

---

## Customizing before import

Open any file and edit before running — it's plain SQL. Common tweaks:

- **Hotel name** — change the string in the `INSERT INTO nex_hotels` line. (Note:
  if you change it after a previous import, the `ON DUPLICATE KEY` match by name
  will no longer hit, so a *new* hotel row will be created. Either rename via
  `/hoteladmin` instead, or delete the old row first.)
- **Per-room price** — find the `nex_hotel_rooms` `VALUES` block and change the
  `price` (5th column).
- **Front-desk position** — change `entrance_x/y/z/h` and `exit_x/y/z/h`.
- **Blip color / sprite** — edit the JSON in the `blip` column.
- **Disable the entrance ped** — set `ped` to `NULL`.

You can also do all of this in-game via `/hoteladmin` after the import — the
admin UI writes back to the same tables.

---

## Removing a hotel

If you imported by mistake or want a clean slate:

```sql
DELETE FROM nex_hotels WHERE name = 'Opium Nights Hotel';
```

The schema's `ON DELETE CASCADE` will remove all of that hotel's rooms,
elevators, elevator stops, and active rentals automatically.

---

## Adding your own MLO

To add a hotel that doesn't ship with this script:

1. Use `/hoteladmin` in-game to create the hotel and add rooms with the door
   picker.
2. Once you're happy, you can dump the resulting rows out of MySQL into a SQL
   file matching the format of these imports — useful if you want to share or
   redeploy the configuration. (Future versions of `nex_hotels` may add a
   `/hotelexport` command for this.)
