# 🌐 KLB - EconomyCore

**KLB-EconomyCore** gives you a complete live overview of your server’s economy — player balances, totals, top lists, and admin editing — all displayed in a modern and clean **KLB-style dashboard** 💎

---

## 🧠 What is it?

A lightweight core system that reads and visualizes your full in-game economy directly from the database — **no config file, no setup, no bullshit.**

It auto-detects your framework and just works.

---

### ✨ Features

- Live overview of **cash**, **bank**, **dirty**, and **crypto**
- **Top 10 richest players** & **largest accounts**
- Real-time total economy value
- Admin-only player search & balance editor
- Works with **qb-core**, **qbx-core**, and **okokBanking**
- Auto-detects frameworks — no config needed
- KLB-UI with responsive and dark-glass styling

---

## ⚙️ Why there's no config file?

Because it doesn’t need one.  
KLB-EconomyCore automatically:
- Detects your active framework  
- Reads the data directly from your database  
- Checks your admin permissions  
- Hooks into okokBanking automatically if it’s running  

Everything is pre-handled inside the core — that’s why there’s no `config.lua`.

Just **install and start**.

---

## 🔧 Setup (server.cfg)

Add this line to your **server.cfg** before `ensure klb-economycore`:

```bash
add_ace group.admin klb.economy allow
ensure klb-economycore
```

That’s it ✅  
Only players in the `admin` ACE group will be able to open the panel.

---

## 💻 Commands

| Command | Description |
|----------|-------------|
| `/klbadmin` or `/KLBADMIN` | Opens the economy dashboard (admins only) |

---

## 🧩 Dependencies

- **QBCore** or **QBX-Core**
- **oxmysql**
- *(Optional)* **okokBanking**

---

## 🧠 Developer Notes

- Reads all player balances directly from the `players` table  
- Automatically calculates totals, averages, and rankings  
- No configs, no setup — plug and play  
- Includes an export for live totals:

```lua
local totals = exports['klb-economycore']:GetTotals()
print('Total Cash:', totals.cash)
```

---

## 🖤 Credits

Developed by **Klobow / KLB Scripts**  
Focused on speed, style, and simplicity.  
Built with zero config files and maximum performance 🚀
