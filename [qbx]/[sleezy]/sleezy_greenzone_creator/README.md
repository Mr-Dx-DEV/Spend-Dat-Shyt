# Sleezy Development - Advanced Greenzone Creator

Original greenzone / safezone creator built for FiveM with an in-game box editor, ox_lib dialogs, and PolyZone detection.

## Features

- Create safezones directly in-game with `/createsafezone`
- Real-time 3D box preview while moving, sizing, and rotating the zone
- Edit the closest saved zone with `/zonesetting`
- Delete the closest saved zone with `/deletezone`
- Optional admin bypass per zone
- Optional weapon + melee disable
- Optional player invincibility
- Optional global whitelisted weapons
- Optional job-based whitelisted weapons
- Optional vehicle speed limit per zone
- Custom text shown to players inside each zone
- Optional blip + marker support per zone
- JSON persistence with no database required
- Works with ox_lib and PolyZone

## Dependencies

- ox_lib
- PolyZone

## Recommended ACE

```cfg
add_ace group.admin sleezy.greenzone.admin allow
add_principal identifier.fivem:YOURIDHERE group.admin
```

add_ace group.admin sleezy.greenzone.admin allow
# Replace with your own FiveM / license / discord identifier
add_principal identifier.fivem:YOURIDHERE group.admin

## Commands

- `/createsafezone`
- `/creategreenzone`
- `/zonesetting`
- `/deletezone`
- `/listzones`

## Notes

- Edit all wording through `Config.Strings`
- Adjust colors / draw values through `Config.Visuals`
- Change default behavior through `Config.ZoneDefaults`
- Configure weapon and job allow-lists in `Config.WhitelistedWeapons` and `Config.JobWeaponWhitelist`
