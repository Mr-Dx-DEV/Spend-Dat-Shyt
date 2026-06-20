// ============================================================
//   NASTY DEVELOPMENTS — Loading Screen v2
//   Edit this file to customise everything. No other files
//   need to be touched for basic setup.
// ============================================================

var Config = {};

// ── Server Identity ─────────────────────────────────────────
Config.ServerName   = "Spend Dat Shyt";
Config.Tagline      = "Spend Dat Shyt Rp";
Config.Season       = "SEASON 1";
Config.Version      = "v1.0";
Config.MaxPlayers   = 200;

// ── Background ───────────────────────────────────────────────
// List one or more images (put them in ui/images/).
// They will crossfade in order with a slow Ken Burns effect.
// Or set BackgroundType to "video" and add background.mp4.
Config.BackgroundType   = "video";                // "image" | "video"
Config.BackgroundImages = [
  "images/background.png",
  "images/background2.png", 
  "images/background3.png",                         // add more paths as needed
];
Config.BackgroundVideo   = "images/chicago.mp4"; // used when BackgroundType = "video"
Config.SlideshowInterval = 7000;                  // ms between slides

// ── Accent colour ────────────────────────────────────────────
// Change this single hex value to rebrand the entire UI.
Config.AccentColor  = "#ff00ea";                  // default: violet

// ── Social Links ─────────────────────────────────────────────
// Supported icons: "discord" | "youtube" | "tiktok" | "x" | "instagram" | "twitch"
Config.Socials = [
  { icon: "discord",   label: "Discord",   url: "https://discord.gg/YOURLINK" },
  { icon: "youtube",   label: "YouTube",   url: "#" },
  { icon: "tiktok",    label: "TikTok",    url: "#" },
  { icon: "x",         label: "Twitter",   url: "#" },
];

// ── Music ────────────────────────────────────────────────────
// Put .mp3 files in ui/music/ and list them below.
Config.Tracks = [
  { title: "Spend Dat",  artist: "Young Miami",  file: "music/Jumpman.mp3" },
  { title: "FTCU Sleeze Mix",  artist: "Nikki Minaj ft Chris Brown Travis Scott & Sexy Red",  file: "music/Talk.mp3" },
  { title: "We Oustide Tonight",  artist: "Beat King",  file: "music/BangBang.mp3" },
];
Config.DefaultVolume  = 100;    // 0 – 100
Config.AutoPlay       = true;
Config.ShuffleTracks  = false;

// ── Loading Tips ─────────────────────────────────────────────
// Rotate through these while the server loads.
Config.Tips = [
  "Use /help to view all available commands.",
  "Join our Discord for exclusive giveaways and updates!",
  "Report bugs or issues to a staff member in-game.",
  "New Life Rule applies — you forget events after dying.",
  "Check #announcements in Discord for patch notes.",
  "Respect all players — a great RP experience starts with you.",
  "Custom jobs, gangs, and housing are available in-game.",
];
Config.TipInterval = 5000;     // ms between tip changes

// ── Server Rules ─────────────────────────────────────────────
Config.Rules = [
  "Respect all players and staff members at all times.",
  "No random deathmatch (RDM) or vehicle deathmatch (VDM).",
  "Stay in character at all times while in-game.",
  "No metagaming — keep in-game and out-of-game knowledge separate.",
  "No powergaming — do not force roleplay outcomes on others.",
  "New Life Rule: after dying you forget the events that led to your death.",
  "Do not exploit bugs or glitches — report them to staff immediately.",
  "English only in public channels and /ooc chat.",
  "Follow all staff decisions; appeal in Discord if needed.",
  "No advertising or mentioning other servers.",
  "Have fun and make every session memorable!",
];
