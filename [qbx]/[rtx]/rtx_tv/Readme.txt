RTX Television

## DOCUMENTATION

Full installation guide, configuration details and additional tips are available here:
https://rtx-dev.gitbook.io/rtxdev/television

Thank you for purchasing rtx_tv.
If you need help, please join our Discord or contact support.

Discord: https://discord.gg/P6KdaDpgAk
Shop: https://rtx.tebex.io

--------------------------------------------------

REQUIREMENTS

- No dependencies (Standalone ready)

Optional frameworks:
- QBCore
- ESX

--------------------------------------------------

INSTALLATION

1. Add resource

Place the rtx_tv folder into your resources directory.

Example:
resources/[scripts]/rtx_tv

--------------------------------------------------

2. Configure

Open:
rtx_tv/config.lua

Set your framework:

Config.Framework = "standalone"  (standalone / qbcore / esx)

Adjust all other settings based on your needs.

--------------------------------------------------

3. Add to server.cfg

ensure rtx_tv

--------------------------------------------------

FRAMEWORK SETUP

QBCore:

1. Set:
Config.Framework = "qbcore"

2. Import SQL file:
sql_QBCORE.sql

3. Add items into qb-core/shared/items.lua:

tvremote
vehicletv

--------------------------------------------------

EXTERNAL SOURCES

If you want to allow external websites / streams, you must enable it in config:

Config.EnableExternalSources = true

WARNING:
Using external sources means players can load content from the internet.
This may include inappropriate or unsafe content.

You are fully responsible for how this feature is used on your server.

You must follow:
- Cfx.re / FiveM Terms of Service
- Terms of Service of all third-party platforms

Do NOT stream copyrighted content without proper rights.

--------------------------------------------------

ESX:

1. Set:
Config.Framework = "esx"

2. Import SQL file:
sql_ESX.sql

--------------------------------------------------

USAGE

Open TV menu using command:
/tv

Or via item / target (if enabled in config)

--------------------------------------------------

LOCAL MEDIA

Place your files into:

rtx_tv/html/media/

Supported formats:
- mp3
- ogg
- mp4

Script can automatically detect files if enabled in config.

--------------------------------------------------

INTERFACE STYLES

If you want a different UI style, check:

[Other Interface Styles] folder

Instructions for installation are included inside that folder.

--------------------------------------------------

VEHICLE TV

Supports TVs inside vehicles.

You can configure:
- allowed vehicles
- blacklisted vehicles
- vehicle classes
- custom offsets

--------------------------------------------------

PERMISSIONS

Supported systems:
- ACE permissions
- Job permissions
- Identifier whitelist

--------------------------------------------------

DEV TOOLS

/createcustomtv    -> create custom 3D screen
/tvcreator         -> vehicle offset editor

--------------------------------------------------

VIDEO TUTORIALS

Vehicle Offsets Creator:
https://www.youtube.com/watch?v=7Cu8LqRgvj0

In-Game Screen Creator:
https://www.youtube.com/watch?v=5NAdvOsIQ2E

--------------------------------------------------

NOTES

- External websites can be disabled for security
- Blacklist system is available for domains
- Local media is streamed via NUI (no external hosting required)

--------------------------------------------------

## LICENSE / TERMS

1. All purchases are non-refundable
2. Each product may be used on one server (test server allowed)
3. Redistribution is strictly prohibited
4. Violation of these rules may result in legal action

© 2026 RTX Development