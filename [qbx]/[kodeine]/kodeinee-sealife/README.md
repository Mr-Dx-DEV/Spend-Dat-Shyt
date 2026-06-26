# kodeinee-sealife
By **Kodeinee Studios**

Advanced ocean wildlife system for FiveM with framework auto-detection, ambient sea animals, and separate shark attack logic.

## What It Does

`kodeinee-sealife` adds life to the ocean without changing your core gameplay systems.

Included sea life:
- Dolphins
- Humpback whales
- Killer whales
- Stingrays
- Fish
- Tiger sharks
- Hammerhead sharks

Ambient animals are for atmosphere only. They swim around the player and are cleaned up automatically when the player leaves the area.

Shark attacks are separate and are the only part of the script that damages or kills players.

## Framework Support

The script uses `bridge.lua` for auto-detection.

Supported framework modes:
- QBCore
- Qbox
- ESX
- Standalone fallback

Config options:
```lua
Config.Framework = 'auto' -- auto, qbox, qb, esx, standalone
```

Detection order:
1. Qbox / `qbx_core`
2. QBCore / `qb-core`
3. ESX / `es_extended`
4. Standalone fallback

## Inventory Support

Inventory detection is included in `bridge.lua` for full all-framework compatibility and future expansion.

Supported inventory modes:
- ox_inventory
- qb-inventory
- ak47_qb_inventory
- qs-inventory
- none

Config options:
```lua
Config.Inventory = 'auto' -- auto, ox, qb, ak47_qb, qs, none
```

This script does not require items by default.

## Target Support

Target detection is included for compatibility.

Supported target modes:
- qb-target
- ox_target
- none

Config options:
```lua
Config.Target = 'auto' -- auto, qb, ox, none
```

This script does not require target interactions by default.

## Install Guide

1. Drag `kodeinee-sealife` into your server resources folder.

2. Add this to your `server.cfg` ensure kodeinee-sealife
```

3. Restart your server fully.



## Ambient Sea Life Config

Ambient sea life can be turned on or off globally:

```lua
Config.AmbientSealife = {
    Enabled = true,
    MaxAmbientAnimals = 12,
    SpawnIntervalMs = 9000,
}
```

Each animal has its own toggle:

```lua
dolphins = {
    Enabled = true,
    Model = 'a_c_dolphin',
}

humpback_whales = {
    Enabled = true,
    Model = 'a_c_humpback',
}

killer_whales = {
    Enabled = true,
    Model = 'a_c_killerwhale',
}

stingrays = {
    Enabled = true,
    Model = 'a_c_stingray',
}

fish = {
    Enabled = true,
    Model = 'a_c_fish',
}
```

Set any animal to `false` to disable it:

```lua
stingrays = {
    Enabled = false,
}
```

## Shark Attack Config

Shark attacks are separate from ambient animals.

```lua
Config.SharkAttacks = {
    Enabled = true,
    TimeInWaterBeforeAttack = 45,
    RandomizeSharkModels = true,
    SharkModels = {
        'a_c_sharktiger',
        'a_c_sharkhammer',
    },
    BiteDamage = 35,
    BitesToKill = 6,
}
```

Only sharks damage or kill players. Dolphins, whales, stingrays, and fish are set as ambient/invincible and will not attack.

## Ocean Only Mode

By default, the script tries to only run in ocean-style water:

```lua
Config.OnlyOcean = true
```

Set this to `false` if you want sea life to work in any water area.

## Performance Notes

The script is optimized for client-side local spawning:
- Animals spawn only around the local player.
- Animals clean up when far away.
- `MaxAmbientAnimals` prevents spam.
- Shark attacks use a separate timer and only spawn when needed.

Recommended settings:
```lua
Config.AmbientSealife.MaxAmbientAnimals = 8 -- lower-end servers/clients
Config.AmbientSealife.MaxAmbientAnimals = 12 -- normal use
```



## Troubleshooting

### I do not see animals
Make sure you are near ocean water. Also check:
```lua
Config.AmbientSealife.Enabled = true
Config.OnlyOcean = true
```

If testing in non-ocean water, set:
```lua
Config.OnlyOcean = false
```

### Too many animals
Lower this:
```lua
Config.AmbientSealife.MaxAmbientAnimals = 6
```

Or disable heavier animals:
```lua
humpback_whales = { Enabled = false }
killer_whales = { Enabled = false }
```

### Sharks are killing too fast
Adjust:
```lua
Config.SharkAttacks.BiteDamage = 20
Config.SharkAttacks.BitesToKill = 8
Config.SharkAttacks.TimeInWaterBeforeAttack = 60
```

### I want no killing, only ocean life
Set:
```lua
Config.SharkAttacks.Enabled = false
```


```
