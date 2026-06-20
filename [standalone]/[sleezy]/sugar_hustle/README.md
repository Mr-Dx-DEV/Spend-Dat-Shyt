# 💋 Sugar Hustle

A unique FiveM roleplay script for lifestyle and sugar-relationship roleplay. Players use the **Sugar Hustle App** on their phone to meet wealthy NPCs, earn cash and gifts, go on dates, and navigate drama—with optional crime and risk such as robbery and blackmail.

**Author:** RoyalT Customz  
**Version:** 1.0.0

---

## ✨ Features

### Core Experience
- **Multi-Framework Support** — Works with **QBCore**, **QBOX**, and **ESX** (auto-detected).
- **Sugar Partner System** — Find and manage relationships with wealthy NPC partners. Support for **multiple partners** at once with separate relationship levels and cooldowns.
- **Relationship Levels (0–100)** — Build trust for better rewards and tier bonuses (Cold → Warm → Hot → Passionate).
- **Personality Types** — Each partner has a personality that affects payouts and risk:
  - 💎 **Generous** — Higher cash and gift chance, low drama.
  - 😈 **Jealous** — More drama and tension.
  - 💰 **Cheap** — Lower rewards, more drama.
  - 🎭 **Mysterious** — Balanced with surprises.

### Encounters & Rewards
- **Random Encounters** — Meet your partner for cash, luxury gifts, drama, or (rarely) police attention.
- **NPC Interactions** — Flirt, ask for gifts, or argue when you meet in the world.
- **Luxury Rewards** — Configurable items (designer bags, necklaces, perfume, watches, etc.) that can be sold at the **Luxury Goods Dealer** (pawn shop) for dirty money.
- **Dates** — Go on restaurant dates with your partner; stay seated for the duration to earn bonus rewards and relationship.

### App & Messages
- **In-App Messages** — SMS-style messages from your partner in the **Messages** tab.
- **Meet Requests** — Time-limited “Partner wants to meet at [location]” with a **Pay**-style accept button; accepting and showing up gives a bonus reward multiplier on the next encounter.
- **Optional AI Messages** — Use an OpenAI-compatible API (e.g. Ollama) to generate dynamic partner messages and a **“Text your partner”** chat for in-character replies.
- **App Notifications** — Get in-game alerts when your partner sends a message or a meet request while the app is closed.

### Crime & Risk
- **Robbery** — Lure your partner to your location and rob them at gunpoint. Big cash payout but heavy relationship penalty and optional police alert.
- **Blackmail** — After **drama** or **robbery**, your partner (or an “associate”) can send a **blackmail message** in the app: pay a set amount before the timer runs out, or they go to the police and your relationship takes a hit.  
  - Message type **“Blackmail”** in the Messages tab with a countdown and **“Pay $X”** button.  
  - If you don’t pay in time: configurable chance to trigger police and a relationship penalty.

### Economy & Side Activities
- **Luxury Goods Dealer (Pawn Shop)** — Sell luxury items from encounters for dirty money at a fixed location (e.g. Strawberry Ave).
- **The Plug** — In-app contact to order drugs (configurable products); choose pickup or delivery with cooldowns and optional runner arrival flow.

### Integration & Polish
- **Police Alerts** — Optional integration with **ps-dispatch** or **cd_dispatch** for drama, police encounter outcome, robbery, or unpaid blackmail.
- **Cooldowns** — Configurable timers for finding partners, encounters, flirts, robbery, and plug contact.
- **ox_target or qb-target** — For all NPC interactions (partner and pawn shop).

---

## 📋 Requirements

- [ox_lib](https://github.com/overextended/ox_lib)
- One of: **qb-core**, **qbx-core**, **es_extended**
- **ox_target** or **qb-target**

---

## 📦 Installation

1. Place the `sugar_hustle` folder in your server’s `resources` directory.
2. Add required items (e.g. `sugarphone`) to your framework — see **INSTALLATION/ITEMS_REFERENCE.md**.
3. Edit **config.lua** (cooldowns, rewards, blackmail, police, AI, etc.). Only **config.lua** and **locales/** are editable; do not modify protected script files.
4. Add `ensure sugar_hustle` to your `server.cfg` (after `ox_lib` and your framework).
5. Restart the server or run `ensure sugar_hustle` in the server console.

---

## 🎮 How to Use (Players)

1. **Get the Sugar Phone** — Obtain the Sugar Phone item (`sugarphone` by default).
2. **Open the app** — Use the item to open the Sugar Hustle app. If **Config.Debug** is enabled, you can also use `/sugarhustle`.
3. **Find a partner** — Use “Find Sugar Partner” (respects cooldowns and max partners).
4. **Check Messages** — Read partner messages, accept time-limited meet requests, and **pay or ignore blackmail** if you receive it.
5. **Meet your partner** — Go to the suggested location (or accept a meet request) and interact: **Flirt**, **Ask for Gift**, or **Argue**.
6. **Optional** — Go on a **date**, **lure and rob** a partner (with consequences), or sell luxury items at the **Luxury Goods Dealer**.
7. **Contact The Plug** — Use the in-app Plug option to order products (if enabled).

---

## ⚙️ Configuration

All tuning is done in **config.lua**, including:

- Cooldowns (find partner, encounters, flirts, robbery, plug)
- Cash and gift rewards and personality multipliers
- Drama and police alert chances
- **Blackmail** — enable/disable, chances after drama/robbery, amount range, pay timer, and consequences (police chance, relationship loss)
- Robbery (min/max cash, relationship penalty, police chance, hands-up duration)
- Meeting and date locations
- Pawn shop and Plug settings
- Optional AI (API URL, model, generate messages, partner chat)
- Locale and notification options

---

## 🔧 Troubleshooting

- **NUI callback error / “Failed to fetch”** — The client script may not have loaded or the resource may need a full restart. In server console run `ensure sugar_hustle`. If the issue persists, have players **reconnect** to the server so they receive the latest client scripts.
- **“attempt to index a nil value (global 'os')”** — This indicated use of `os` on the client; the script has been updated to use FiveM-safe time (no `os` on client). Ensure you are running the latest version and restart the resource.
- **App doesn’t open** — Confirm the required item exists in your framework and the player has it. Check **config.lua** → `Config.RequiredItem`.
- **No framework detected** — Ensure **qb-core**, **qbx-core**, or **es_extended** is started before `sugar_hustle` in `server.cfg`.

---

## 📊 Personality Types (Summary)

| Type         | Cash Mult | Gift Bonus | Drama % |
|-------------|-----------|------------|---------|
| 💎 Generous   | 1.5x      | +15%       | 5%      |
| 😈 Jealous    | 1.0x      | +5%        | 35%     |
| 💰 Cheap      | 0.6x      | -10%       | 25%     |
| 🎭 Mysterious | 1.2x      | +10%       | 15%     |

---

For item definitions and detailed setup, see **INSTALLATION/ITEMS_REFERENCE.md** and **INSTALLATION/README.md**.
