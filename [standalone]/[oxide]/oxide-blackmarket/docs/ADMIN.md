# Admin Commands

Reference for administrative commands and permissions in `oxide-blackmarket`.

Commands are registered with `ox_lib` via `lib.addCommand`.

## Commands

| Command | Description | Permission |
|---|---|---|
| `/relocatedealer` | Forces the dealer to relocate immediately | `group.admin` |
| `/dealerstatus` | Shows whether the dealer is active and prints server details | `group.admin` |
| `/godealer` | Teleports you to the live dealer position | `group.admin` |
| `/setblackmarketrep` | Sets a player's rep value | `group.admin` |
| `/checkblackmarketrep` | Checks a player's rep and tier | `group.admin` |

## Dealer Commands

### `/relocatedealer`

Usage:

```text
/relocatedealer
```

Behavior:

- despawns the current dealer
- waits for cleanup
- spawns a fresh dealer at a random configured location
- resets dealer stock

### `/dealerstatus`

Usage:

```text
/dealerstatus
```

Behavior:

- sends an in-game notification telling you whether the dealer is active
- prints the active net ID, spawn index, and live coords to server console when the dealer exists

### `/godealer`

Usage:

```text
/godealer
```

Behavior:

- teleports the admin 3 units in front of the dealer
- uses the dealer's live position rather than the original spawn point

## Reputation Commands

### `/setblackmarketrep`

Usage:

```text
/setblackmarketrep [playerId] [amount]
```

Examples:

```text
/setblackmarketrep 1 0
/setblackmarketrep 1 350
/setblackmarketrep 1 1000
```

Behavior:

- writes the new value to `blackmarket_rep`
- notifies the admin on success
- notifies the target player with the new rep and tier name

Tier thresholds:

| Rep | Tier |
|---|---|
| `0-99` | `0` |
| `100-299` | `1` |
| `300-599` | `2` |
| `600-999` | `3` |
| `1000+` | `4` |

### `/checkblackmarketrep`

Usage:

```text
/checkblackmarketrep
/checkblackmarketrep [playerId]
```

Behavior:

- checks your own rep if no player ID is supplied
- returns rep, tier number, and tier name

## Permissions

All admin commands are restricted to `group.admin`.

ACE example:

```cfg
add_ace group.admin command.relocatedealer allow
add_ace group.admin command.dealerstatus allow
add_ace group.admin command.godealer allow
add_ace group.admin command.setblackmarketrep allow
add_ace group.admin command.checkblackmarketrep allow
```

If your server grants `group.admin` through your framework or permission stack already, use that existing path.

## Notes

- `Config.Debug = true` produces useful `[oxide-blackmarket]` server logs while testing.
- `/dealerstatus` and `/godealer` are the fastest way to validate a fresh install.
- Dealer commands operate on the live synced ped, not just the last configured spawn point.

## Next Steps

- `CONFIGURATION.md`
- `EXPORTS.md`
- `TROUBLESHOOTING.md`
