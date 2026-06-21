# Sugar Hustle – Feature Ideas

Suggested features you can add to extend the Sugar Hustle system. Each section groups ideas by theme. Use what fits your server; many can be toggled in `config.lua`.

---

## Relationship & Partner Depth

| Feature | Description | Notes |
|--------|-------------|--------|
| **Partner history / ex-partners** | Store past partners (name, personality, last level). Option to “reconnect” with an ex (shorter cooldown, different dialogue). | Persist in server DB/key-value; show in app as “Past arrangements”. |
| **Partner preferences** | Partner has a “type” (e.g. prefers certain locations, gifts). Meeting at preferred spot or giving preferred gift gives a small relationship/reward bonus. | Add `preferredLocationIds`, `preferredGiftItems` (or tags) to partner data; check in encounter/date logic. |
| **Relationship milestones** | At 25, 50, 75, 100: one-time bonus (cash, rare gift, or unlock like “VIP date location”). | Server checks level on encounter complete; grant milestone reward once per partner. |
| **Partner “mood”** | Short-term mood (happy, annoyed, suspicious) affecting gift chance, drama chance, or cash multiplier for the next 1–2 encounters. | Derived from last interaction (flirt/gift/argue/robbery) and optionally from AI messages. |



---

## App & Phone Experience

| Feature | Description | Notes |
|--------|-------------|--------|

| **Partner profile in app** | In the app, show partner photo (ped headshot or placeholder), name, personality, relationship level, and “last seen” or “last met”. | Reuse existing partner data; add optional `profileImage` URL or ped screenshot. |
| **Block / report partner** | “Block this partner” (stops messages/meet requests; they can’t be re-matched for X days). “Report” could be a log for admins or trigger a small reputation hit. | Server flag on partner; exclude from “find partner” and from message generation. |
| **Sugar “stories” or feed** | Fake social feed in the app: “Partner posted a story at Vinewood” or “New match available in your area.” Clicking could open messages or add a meet request. | Config list of story texts; pick random when opening app; optional link to meet request. |
| **Premium / VIP subscription** | Optional in-game “subscription” (item or money over time) that reduces cooldowns, adds extra date locations, or increases gift chance. | Config flag `Config.VIPEnabled`; check item or server-side “subscription” expiry. |

---

## Encounters & Dates

| Feature | Description | Notes |
|--------|-------------|--------|
| **More date types** | Besides “sit at restaurant”: yacht trip (boat scene), spa, shopping (walk alongside NPC), photo op (prop camera, pose). | New `Config.DateTypes` with coords, props, duration; reuse seat/despawn logic where possible. |
| **Date mini-games** | During the date: simple “press key at the right time” or “choose dialogue” (A/B/C) that slightly adjusts relationship or reward. | NUI mini-game or ox_lib input; server applies small +/- relationship or multiplier. |
| **Gift-giving to partner** | Player can give partner an item (e.g. expensive_perfume) for a relationship boost or a better next encounter. | Target option “Give gift”; remove item; add relationship points; optional dialogue. |
| **Location-based bonuses** | Certain meeting/date locations give a small cash or relationship multiplier (e.g. “Vinewood Villa” = 1.2x). | Add `rewardMultiplier` or `relationshipBonus` to `Config.MeetingLocations` and `Config.DateLocations`. |
| **Time-of-day effects** | Night meetings have different rewards or drama chance (e.g. “late night” = more cash, higher drama). | Get server/client hour; apply multiplier or outcome modifier in encounter logic. |

---

## Economy & Progression

| Feature | Description | Notes |
|--------|-------------|--------|
| **Reputation / street cred** | Global “sugar reputation” (0–100): more successful encounters and fewer dramas increase it; higher rep unlocks better partners or plug/pawn deals. | Server-side key (e.g. `sugar_reputation`); increase/decrease on encounter end; gate “find partner” tier by rep. |
| **Achievements / titles** | “First date”, “10 gifts received”, “Survived 5 dramas”, “Loyal to one partner (50+ level)”. Reward: title, badge in app, or one-time cash/item. | Track counts in server (or DB); on trigger grant achievement and reward. |
| **Expenses** | Optional “upkeep” for the lifestyle: pay a small fee (e.g. every in-game day) to keep the app “active,” or pay per date location (e.g. restaurant cover). | Config `Config.UpkeepEnabled`, amount and interval; deduct from bank/cash. |
| **Pawn shop loyalty** | Selling X items at the pawn shop unlocks a one-time or recurring discount or “premium buyer” dialogue. | Track `pawn_sales_count`; at threshold set flag for better sell price or extra line. |
| **Plug loyalty / bulk deals** | After N orders, plug offers a “bulk deal” (e.g. 10% off) or a rare item. | Similar to pawn loyalty; track orders; at threshold add special offer in plug menu. |

---

## Crime & Risk

| Feature | Description | Notes |
|--------|-------------|--------|

| **Blackmail** | After drama or robbery, partner (or “associate”) can send in-app blackmail: pay X or they go to police / relationship ruined. | New message type “Blackmail”; timer to pay; if not paid, trigger police or rep loss. |
| **Bodyguard / enforcer** | Partner sometimes spawns with a bodyguard; robbery is harder (longer hands-up, or need to “deal with” bodyguard first). | Config `BodyguardChance`; spawn second ped; robbery flow checks and adjusts. |
| **Undercover cop** | Very low chance that “partner” is an undercover cop; encounter leads to arrest or fine. | New outcome type; integrate with your police/jail script. |
| **Wanted level after robbery** | Robbery adds a small wanted level or triggers a police chase. | Use native `SetPlayerWantedLevel` or your dispatch; configurable. |

---

## Social & Multiplayer

| Feature | Description | Notes |
|--------|-------------|--------|
| **Partner sharing** | “Introduce” your partner to another player (e.g. both at same location); that player gets a one-time encounter or a new partner option. | Server event; validate both nearby; create temporary encounter for second player. |
| **Rival sugar** | Rare encounter: another “sugar” (NPC or even player) is with your partner; choice to confront (drama) or leave. | Random event at encounter start; spawn second NPC; dialogue options. |
| **Crew / gang angle** | If player is in a crew, plug or pawn shop gives a small discount; or “crew job” to deliver plug orders for a cut. | Check crew/gang via your framework; apply discount or extra delivery mission. |

---

## Quality of Life & Immersion

| Feature | Description | Notes |
|--------|-------------|--------|
| **More locales** | Add `es`, `de`, `fr` (etc.) in `Config.Locales` so server owners can translate all strings. | Copy `en` block, translate values; set `Config.Locale` per server. |
| **Config presets** | “Casual”, “Hardcore”, “Roleplay” presets that set cooldowns, rewards, and drama chance in one go. | Extra file or table `Config.Presets`; apply on load or via convar. |
| **Admin commands** | Commands to grant sugar phone, clear cooldowns, set relationship level, or spawn test partner. | Server-only; use Ace permissions; call existing server functions. |
| **Statistics in app** | In-app stats: total earned, gifts received, dates completed, dramas survived. | Server tracks and returns on app open; NUI displays in a “Stats” tab. |
| **Partner “last location”** | After an encounter, show a short hint: “They’re often at the golf club” (random from a list) to encourage revisiting that area. | Store or pick from `Config.MeetingLocations`; show in Messages or Profile. |

---

## Optional Integrations

| Feature | Description | Notes |
|--------|-------------|--------|
| **Phone integration** | If you use a phone resource (e.g. qb-phone, gksphone), add a “Sugar Hustle” app inside that phone. | Your script opens NUI from the phone’s app list; same NUI, different entry point. |
| **Inventory integration** | “Use” luxury items (e.g. wear perfume) for a temporary encounter bonus before next meeting. | Item use callback; set a short-lived server flag; encounter logic reads it. |
| **Property / MLO** | Dedicated “sugar lounge” or “date spot” MLO: entering triggers a special encounter or date type. | Zone check or door interaction; run encounter/date with `locationId` for that MLO. |
| **Vehicles** | Partner sometimes arrives in a specific car; player can get a “ride” (passenger) to next location for a small fee or relationship gain. | Spawn vehicle with partner as driver; teleport or drive to second coords. |

---

## Implementation Priority (suggested)

- **Quick wins:** App notifications, statistics in app, more locales, admin commands, location-based bonuses.
- **Medium:** Partner history/ex-partners, reputation, achievements, more date types, AI encounter reactions.
- **Larger:** ~~Multiple partners~~ (done), date mini-games, blackmail, phone resource integration.

Use this list as a roadmap and enable or implement features via `config.lua` and optional modules where possible.
