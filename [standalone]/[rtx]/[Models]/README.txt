RTX Housing – README

INSTALL GUIDE:
https://rtx-dev.gitbook.io/rtxdev/rtx-housing-system/installation

Thank you for purchasing rtx_housing.
If you need help, please join our Discord or contact support.

Discord: https://discord.gg/P6KdaDpgAk
Shop: https://rtx.tebex.io

---

## REQUIREMENTS

Core resources:

* rtx_housing (main script)
* rtx_housing_coreprops (models / props)

Optional resources:

* rtx_housing_shells (shell pack)
* rtx_krapea_mlo (Krapea MLO)
* screenshot-basic (required only for taking property photos)

---

## INSTALLATION

1. Add resources

* Place rtx_housing into your resources folder (Script folder)
* Place rtx_housing_coreprops into your resources folder (Models folder)

Add to server.cfg:
ensure rtx_housing
ensure rtx_housing_coreprops

2. Framework setup
   Open config.lua and set your framework:

* standalone  -> Config.Framework = "standalone"
* qbcore      -> Config.Framework = "qbcore"
* esx         -> Config.Framework = "esx"

Then configure the rest of config.lua to your needs.

Standalone note:
If you use standalone mode, you must create your own item definitions
and handle money / inventory logic in server/other.lua.
Use ESX or QBCore examples as reference.

---

## DATABASE (SQL)

1. Import SQL_INSERT.sql into your database (SQL folder)
2. Optional: import Example_Properties.sql if you want example houses

---

## ITEMS SETUP

Go to the Items folder and install items based on your framework:

* QBCore / OX Inventory:
  Copy items into your items definition file

* ESX:
  Import the SQL items into your database

---

## OPTIONAL PACKS

Shells pack:

* Add rtx_housing_shells to your resources
* Add to server.cfg:
  ensure rtx_housing_shells

Krapea MLO:

* Add rtx_krapea_mlo to your resources
* Add to server.cfg:
  ensure rtx_krapea_mlo

---

## PROPERTY CREATOR

Command:
/propertycreator

This command opens the in-game property creator.

Permissions:
You must configure permissions in server/other.lua.

---

## PROPERTY CREATOR – PHOTOS

If you want to take photos in the property creator:

* You must have screenshot-basic installed
* You must set a photo webhook in server/other.lua

---

SHELLS / INTERIORS COMPATIBILITY

RTX Housing System supports multiple interior shell packs.
You can use both free and paid shell packs listed below.

FREE SHELL PACKS

ENVI-SHELLS (free)
https://envi-scripts.tebex.io/package/6407814

K4MB1 Starter Pack (free)
https://k4mb1maps.com/product/5015840

OTHER COMPATIBLE SHELL PACKS

K4MB1 Housing Shells
https://k4mb1maps.com/product/4741607

Jamaring Housing Shells
https://jamaring-maps.tebex.io/category/Housing-Shells

DC CUSTOMZ Housing Shells
https://www.dccustomz.com/product/6408015

IMPORTANT NOTES

* Shell packs must be installed as separate resources.

* Make sure all shell resources are started before rtx_housing.

* If you do not own or use some of the shell packs listed above,
  make sure to remove all related shells from config/shells.lua.
  Leaving shells from missing packs in the config may cause interiors
  to not load correctly or produce errors.

---

## DEVELOPER NOTES

Various exports and developer utilities are available
in the [DOCS] folder.

---

## LICENSE / TERMS

1. All purchases are non-refundable
2. Each product may be used on one server (test server allowed)
3. Redistribution is strictly prohibited
4. Violation of these rules may result in legal action

© 2025 RTX Development. All rights reserved.