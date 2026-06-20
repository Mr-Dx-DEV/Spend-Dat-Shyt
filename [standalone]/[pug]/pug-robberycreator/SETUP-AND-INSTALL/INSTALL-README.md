# 💰 Pug Robbery Creator

## 💬 Support & Store
Support Discord: [https://discord.gg/jYZuWYjfvq]  
Other scripts: [https://pug-webstore.tebex.io/]

## ⚙️ Installation Instructions
1. Add this anywhere in your `server.cfg` or custom doors will not work:
```cfg
setr game_enableDynamicDoorCreation "true"
```
2. Remove these default robbery scripts if you already have them:
   - `qb-bankrobbery`
   - `qb-jewelry`
   - `qb-storerobbery`
3. Add the items from `qb-items.md` or `ox-items.md` to:
   - `qb-core/shared/items.lua`
   - `ox_inventory/data/items.lua`
4. Add the item PNGs from `pug-robberycreator/SETUP-AND-INSTALL/Item-PNGs` into your inventory item image folder.
5. Install house robbery shell interiors (qb-interior `https://github.com/qbcore-framework/qb-interior`) (lev-apartments `https://github.com/levdevlev/lev-apartments`) (K4MB1-startershells `https://k4mb1maps.com/product/5015840`)
6. Install my free pawn shop script to go with the house and robbery progression lot by default `https://github.com/PugDev23/pug-pawnshop`
7. Read the **Mini Games To Download** section if you want extra minigame options.
8. Go to each robbery type and load the presets that you want to use. `(Dashboard page for main robbery load preset robberies button)`




## 📌 Helpful Notes
1. This is a **creator script**, which means almost everything is optional. You can set up robberies however you want, and creativity is encouraged.
2. If you use the **thermite and bag scene** animation and enable **Create Explosion At Target Coords**, the thermite prop will change into a C4 prop.
3. When editing robbery stages, you can rename or delete a stage by hovering over the stage tab on the left side.
4. Bank truck and ATM robbery police alert notifications can be adjusted in `open.lua`.
5. On the hackable door step, if you set the prop to the keypad, the selected minigame will not matter because the keypad uses its own hidden passcode system.
6. Police jobs receive a second target option on every robbery step that lets them reset that step.
7. You can move each robbery step up or down from the top-right of the step.
8. Add `ReplacePropMini = true` to any animation inside `Config.Animations` to delete the prop used in that step with that animation. This is already set on the `grab money` and `grab` animations.
9. You can duplicate minigames in the config with different settings, such as easy and hard safe cracker versions.
10. You can configure one minigame option to run multiple minigames before the player succeeds.
11. Recommended `server.cfg` setting to remove the blue screen kill effect when killing NPC guards:
```cfg
setr profile_skfx 0 # Disable Screen Kill Effects
```
12. Useful FiveM tip: go to the main FiveM page, open **Settings > Game**, and enable **Fix UI Lag**.




## 🚪 QB-Doorlock Users Optional Setup
1. If you use preset robberies with `qb-doorlock`, you must configure all robbery door locks manually because `qb-doorlock` does not support the same automatic functionality.
2. I highly recommend using `ox_doorlock` instead. It is free and one of the best doorlock systems available: [https://github.com/overextended/ox_doorlock/releases]
3. If you still use `qb-doorlock`, you can add a `Name` variable to your `Config.Doorlist` data:
```lua
Name = "YOUR DOOR NAME"
```
The robbery creator will automatically recognize this variable, making doors easier to find in the menu.

## 🎮 Mini Games To Download
These are optional, but good to have if you want more robbery options. The script is already pre-configured for them, so once installed correctly, they will automatically show in the creator menu.

**Important:** make sure these minigames are ensured **before** `pug-robberycreator` in your `server.cfg`. If a downloaded resource has `-main` at the end of the folder name, remove `-main`.

1. **t3_lockpick**  
   Download: [https://github.com/T3development/t3_lockpick]

2. **Inspired Minigames Pack**  
   Download: [https://forum.cfx.re/t/free-standalone-fivem-minigames-nopixel-4-0-minigames/5248433]  
   Preview: [https://forum-cfx-re.akamaized.net/optimized/5X/a/e/7/6/ae76f40104ba526e11511cd53e3c39f2f28b4216_2_418x500.png]  
   Settings can be adjusted in the config.

3. **Finger Print**  
   Download: [https://github.com/utkuali/Finger-Print-Hacking-Game]  
   Preview: [https://forum-cfx-re.akamaized.net/original/4X/6/5/c/65c86adc33bcd5fb12d67b6eef97d6f291a1c9a6.png]  
   Settings can be adjusted in the config.

4. **ultra-voltlab**  
   Download: [https://github.com/ultrahacx/ultra-voltlab/releases/tag/1.1.2]  
   Preview: [https://forum-cfx-re.akamaized.net/optimized/4X/4/b/d/4bd9fa64e853c7bbeecef701fe45f5a7b7cfa9e3_2_517x290.png]  
   If the downloaded folder has a version number at the end, remove it.

5. **boii_minigames**  
   Download: [https://github.com/boiidevelopment/boii_minigames]  
   Preview: [https://www.youtube.com/watch?v=LgTMKqg4d8w]

6. **Original Safe Cracking**  
   Download: [https://github.com/VHall1/pd-safe?tab=readme-ov-file]  
   Important: remove the `TaskPlayAnim` at line 217 in its client file.

7. **ps-ui Minigame Pack**  
   Download: [https://github.com/Project-Sloth/ps-ui]

8. **ran-minigames Pack**  
   Download: [https://github.com/RanDXDev/ran-minigames]




## 📝 Sticky Notes & Passcodes
Sticky note passcode steps provide the code required for the digital keypad. Placement matters because the sticky note step needs to be close enough to the keypad step in the robbery sequence so the system can properly remove and reset the sticky note after the correct code is entered.

For the sticky note passcode to be removed and reset after the code is correctly entered, place the sticky note step within **three steps above or below** the digital keypad step.
