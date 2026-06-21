# 🔮 Nasty RP — Loading Screen
**by Nasty Developments**

A custom FiveM loading screen with purple crystal theme, local MP3 music player, Discord/Rules buttons, and animated loading bar.

---

## 📦 Installation

1. **Drop the folder** `nasty_loadingscreen` into your FiveM server's `resources/` directory.

2. **Add to server.cfg:**
   ```
   ensure nasty_loadingscreen
   ```

3. **Add your music** — copy your `.mp3` files into:
   ```
   nasty_loadingscreen/ui/music/
   ```

4. **Register tracks in config.js:**
   ```js
   Config.Tracks = [
     { title: "My Song",  artist: "Artist", file: "music/mysong.mp3" },
   ];
   ```

5. **Add a background** — put `background.jpg` (or `.mp4`) into:
   ```
   nasty_loadingscreen/ui/images/
   ```
   Then set in `config.js`:
   ```js
   Config.BackgroundType  = "image"; // or "video"
   Config.BackgroundImage = "images/background.jpg";
   ```

6. **Set your Discord link** in `config.js`:
   ```js
   Config.DiscordLink = "https://discord.gg/YOURLINK";
   ```

7. **Edit server rules** in `config.js` — the `Config.Rules` array.

---

## 📁 File Structure
```
nasty_loadingscreen/
├── fxmanifest.lua
├── client/
│   └── main.lua
└── ui/
    ├── index.html
    ├── style.css
    ├── script.js
    ├── config.js      ← Edit this!
    ├── images/
    │   ├── logo.png
    │   └── background.jpg  ← Your background here
    └── music/
        └── *.mp3           ← Your tracks here
```

---

## ✅ Compatible With
- ESX / ESX Legacy
- QBCore
- QBX
- Standalone (no framework needed)

---

## 🎵 Music Player Features
- Local MP3 playback (no YouTube dependency)
- Track list with click-to-play
- Previous / Play-Pause / Next controls
- Volume slider
- Animated equalizer bars
- Progress bar with seek

---

## 🎨 Customization Tips
- Change `--purple-core` in `style.css` to match a different accent color
- Swap logo by replacing `ui/images/logo.png`
- Add more tracks freely to `Config.Tracks`
