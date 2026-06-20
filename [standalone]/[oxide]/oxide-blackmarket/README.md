# oxide-blackmarket

Dynamic black market dealer gameplay for Oxide servers using `o-link`, with dealer relocation, buy/sell trading, reputation tiers, police pressure, pager intel, and hit squad retaliation.

## Highlights

- One synced dealer ped managed server-side and relocated on a timer
- Reputation stored in `blackmarket_rep` metadata through `o-link.character`
- Tier-based or fully unlocked shop flow depending on `Config.EnableTiers`
- Dirty-money transactions using either an account or an inventory item
- Police surrender and arrest flow using `Config.PoliceJobs`
- Tier-based pager intel with Tier 4 phone/email integration through `olink.phone`
- Secure server-side loot bags on dealer death

## Quick Start

1. Ensure dependencies:
   - `ox_lib`
   - `o-link`
   - OneSync enabled
2. Start the resource after `o-link`:

```cfg
ensure ox_lib
ensure o-link
ensure oxide-blackmarket
```

3. Add the pager item to the inventory system used by your `o-link` stack:

```lua
blackmarket_pager = {
    name = 'blackmarket_pager',
    label = 'Burner Pager',
    weight = 100,
    type = 'item',
    image = 'blackmarket_pager.png',
    unique = true,
    useable = true,
    shouldClose = true,
    description = 'A disposable pager for underground contacts'
}
```

4. Review `shared/config.lua` and `shared/items.lua`.
5. Restart the server. The dealer spawns automatically on resource start.

## Dependencies

| Resource | Purpose |
|---|---|
| `ox_lib` | Locale, command registration, utility helpers |
| `o-link` | Framework, inventory, money, notify, phone, banking, callback, and job abstractions |
| OneSync | Required for the server-created dealer ped and entity sync |

## Reputation Tiers

| Tier | Name | Rep Required |
|---|---|---|
| `0` | Unknown | `0` |
| `1` | Street | `100` |
| `2` | Connected | `300` |
| `3` | Trusted | `600` |
| `4` | Inner Circle | `1000` |

If `Config.EnableTiers = false`, all shop tiers are exposed and rep gain/loss notifications are skipped.

## Documentation

| Document | Description |
|---|---|
| [Installation](docs/INSTALLATION.md) | Setup, startup order, pager item, verification |
| [Features](docs/FEATURES.md) | Gameplay flow and system behavior |
| [Configuration](docs/CONFIGURATION.md) | Current config and inventory reference |
| [Admin](docs/ADMIN.md) | Commands, permissions, and admin workflow |
| [Exports](docs/EXPORTS.md) | Exports, callbacks, and events |
| [Troubleshooting](docs/TROUBLESHOOTING.md) | Current integration and runtime issues |
