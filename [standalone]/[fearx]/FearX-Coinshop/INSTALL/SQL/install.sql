CREATE TABLE IF NOT EXISTS `fearx_coinshop` (
    `identifier` VARCHAR(60) NOT NULL,
    `coins` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `fearx_coinshop_items` (
    `id` VARCHAR(50) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` VARCHAR(255) DEFAULT '',
    `category` ENUM('vehicle', 'item', 'weapon', 'tool') NOT NULL DEFAULT 'item',
    `tags` TEXT DEFAULT '[]',
    `price` INT NOT NULL DEFAULT 0,
    `images` TEXT DEFAULT '[]',
    `spawn_name` VARCHAR(50) DEFAULT NULL,
    `item_name` VARCHAR(50) DEFAULT NULL,
    `item_count` INT DEFAULT 1,
    `weapon_name` VARCHAR(50) DEFAULT NULL,
    `trending` TINYINT(1) DEFAULT 0,
    `custom_category` VARCHAR(50) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `fearx_coinshop_categories` (
    `id` VARCHAR(50) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `icon` VARCHAR(500) DEFAULT '',
    `type` VARCHAR(20) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `fearx_coinshop_purchases` (
    `id` INT AUTO_INCREMENT,
    `identifier` VARCHAR(60) NOT NULL,
    `item_id` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL,
    `purchased_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `fearx_coinshop_deals` (
    `id` VARCHAR(50) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` VARCHAR(255) DEFAULT '',
    `price` INT NOT NULL DEFAULT 0,
    `image` VARCHAR(500) DEFAULT '',
    `items` TEXT DEFAULT '[]',
    `expires_at` TIMESTAMP NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `fearx_coinshop_codes` (
    `id` INT AUTO_INCREMENT,
    `tbx_id` VARCHAR(100) NOT NULL UNIQUE,
    `coins` INT NOT NULL DEFAULT 0,
    `status` ENUM('pending', 'redeemed') NOT NULL DEFAULT 'pending',
    `redeemed_by` VARCHAR(60) DEFAULT NULL,
    `redeemed_at` TIMESTAMP NULL DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `fearx_coinshop_redeems` (
    `id` INT AUTO_INCREMENT,
    `identifier` VARCHAR(60) NOT NULL,
    `redeem_key` VARCHAR(100) NOT NULL UNIQUE,
    `coins_added` INT NOT NULL DEFAULT 0,
    `redeemed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `fearx_coinshop_settings` (
    `key` VARCHAR(50) NOT NULL,
    `value` TEXT NOT NULL,
    PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `fearx_coinshop_categories` (`id`, `name`, `icon`, `type`) VALUES
('vehicles', 'Vehicles', 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHZpZXdCb3g9JzAgMCAyNCAyNCcgZmlsbD0nbm9uZScgc3Ryb2tlPSd3aGl0ZScgc3Ryb2tlLXdpZHRoPScyJyBzdHJva2UtbGluZWNhcD0ncm91bmQnIHN0cm9rZS1saW5lam9pbj0ncm91bmQnPjxwYXRoIGQ9J003IDExbDItNGg2bDIgNCcvPjxyZWN0IHg9JzQnIHk9JzExJyB3aWR0aD0nMTYnIGhlaWdodD0nNicgcng9JzEnLz48Y2lyY2xlIGN4PSc3LjUnIGN5PScxNycgcj0nMS41Jy8+PGNpcmNsZSBjeD0nMTYuNScgY3k9JzE3JyByPScxLjUnLz48L3N2Zz4=', 'vehicle'),
('items', 'Items', 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHZpZXdCb3g9JzAgMCAyNCAyNCcgZmlsbD0nbm9uZScgc3Ryb2tlPSd3aGl0ZScgc3Ryb2tlLXdpZHRoPScyJyBzdHJva2UtbGluZWNhcD0ncm91bmQnIHN0cm9rZS1saW5lam9pbj0ncm91bmQnPjxwYXRoIGQ9J00xMiAzbDkgNC41djlMMTIgMjFsLTktNC41di05TDEyIDN6Jy8+PHBhdGggZD0nTTEyIDEybDktNC41TTEyIDEydjlNMTIgMTJMMyA3LjUnLz48L3N2Zz4=', 'item'),
('weapons', 'Weapons', 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHZpZXdCb3g9JzAgMCAyNCAyNCcgZmlsbD0nbm9uZScgc3Ryb2tlPSd3aGl0ZScgc3Ryb2tlLXdpZHRoPScyJyBzdHJva2UtbGluZWNhcD0ncm91bmQnPjxjaXJjbGUgY3g9JzEyJyBjeT0nMTInIHI9JzgnLz48cGF0aCBkPSdNMTIgMnY0TTEyIDE4djRNMiAxMmg0TTE4IDEyaDQnLz48L3N2Zz4=', 'weapon'),
('tools', 'Tools', 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHZpZXdCb3g9JzAgMCAyNCAyNCcgZmlsbD0nbm9uZScgc3Ryb2tlPSd3aGl0ZScgc3Ryb2tlLXdpZHRoPScyJyBzdHJva2UtbGluZWNhcD0ncm91bmQnIHN0cm9rZS1saW5lam9pbj0ncm91bmQnPjxwYXRoIGQ9J00xNC43IDYuM2ExIDEgMCAwMDAgMS40bDEuNiAxLjZhMSAxIDAgMDAxLjQgMGwzLjc3LTMuNzdhNiA2IDAgMDEtNy45NCA3Ljk0bC02LjkxIDYuOTFhMi4xMiAyLjEyIDAgMDEtMy0zbDYuOTEtNi45MWE2IDYgMCAwMTcuOTQtNy45NGwtMy43NiAzLjc2eicvPjwvc3ZnPg==', 'tool');

INSERT IGNORE INTO `fearx_coinshop_items` (`id`, `name`, `description`, `category`, `tags`, `price`, `images`, `spawn_name`, `trending`) VALUES
('veh_adder', 'Truffade Adder', 'The pinnacle of automotive engineering. A Bugatti Veyron-inspired hypercar with a top speed that will blow your mind.', 'vehicle', '["supercar","fast","luxury"]', 5000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/adder.png"]', 'adder', 1),
('veh_zentorno', 'Pegassi Zentorno', 'Italian engineering at its finest. This Lamborghini-inspired beast dominates every race it enters.', 'vehicle', '["supercar","racing","fast"]', 4500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/zentorno.png"]', 'zentorno', 0),
('veh_t20', 'Progen T20', 'A McLaren P1-inspired masterpiece. Lightweight, powerful, and absolutely gorgeous.', 'vehicle', '["supercar","racing","premium"]', 5500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/t20.png"]', 't20', 1),
('veh_entityxf', 'Overflod Entity XF', 'Koenigsegg meets GTA in this stunning hypercar. One of the fastest cars in the game.', 'vehicle', '["supercar","fast","premium"]', 4800, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/entityxf.png"]', 'entityxf', 0),
('veh_osiris', 'Pegassi Osiris', 'Inspired by the Pagani Huayra, this Italian exotic is pure art on wheels.', 'vehicle', '["supercar","luxury","exotic"]', 4200, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/osiris.png"]', 'osiris', 0),
('veh_tempesta', 'Pegassi Tempesta', 'A Lamborghini Huracan-inspired supercar that combines speed with sleek Italian design.', 'vehicle', '["supercar","fast","racing"]', 3800, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/tempesta.png"]', 'tempesta', 0),
('veh_elegy2', 'Annis Elegy RH8', 'A free-spirited sports car inspired by the Nissan GT-R. Fast, reliable, and a fan favorite.', 'vehicle', '["sports","jdm","racing"]', 1500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/elegy2.png"]', 'elegy2', 0),
('veh_sultanrs', 'Karin Sultan RS', 'A tuner legend. This rally-inspired sedan packs serious power under the hood.', 'vehicle', '["sports","tuner","jdm"]', 2000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/sultanrs.png"]', 'sultanrs', 0),
('veh_banshee', 'Bravado Banshee', 'An American muscle sports car inspired by the Dodge Viper. Raw power and classic styling.', 'vehicle', '["sports","muscle","fast"]', 1800, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/banshee.png"]', 'banshee', 0),
('veh_comet2', 'Pfister Comet', 'A Porsche 911-inspired classic that never goes out of style. Perfect balance of speed and handling.', 'vehicle', '["sports","classic","german"]', 2200, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/comet2.png"]', 'comet2', 0),
('veh_jester', 'Dinka Jester', 'Honda NSX-inspired sports car with razor-sharp handling and aggressive looks.', 'vehicle', '["sports","jdm","racing"]', 2500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/jester.png"]', 'jester', 0),
('veh_dominator', 'Vapid Dominator', 'Pure American muscle inspired by the Ford Mustang. Loud, proud, and fast in a straight line.', 'vehicle', '["muscle","american","classic"]', 1200, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/dominator.png"]', 'dominator', 0),
('veh_gauntlet', 'Bravado Gauntlet', 'A Dodge Challenger-inspired muscle car. V8 rumble and tire-shredding power.', 'vehicle', '["muscle","american","fast"]', 1300, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/gauntlet.png"]', 'gauntlet', 0),
('veh_sandking', 'Vapid Sandking XL', 'The ultimate off-road monster truck. Crushes everything in its path.', 'vehicle', '["offroad","truck","lifted"]', 1800, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/sandking.png"]', 'sandking', 0),
('veh_rebel2', 'Karin Rebel', 'A rugged Toyota-inspired pickup built for the desert. No terrain is too tough.', 'vehicle', '["offroad","truck","rugged"]', 800, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/rebel2.png"]', 'rebel2', 0),
('veh_trophy', 'Vapid Trophy Truck', 'A purpose-built racing truck designed to fly over jumps and tear through dirt.', 'vehicle', '["offroad","racing","fast"]', 2500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/trophytruck.png"]', 'trophytruck', 0),
('veh_kuruma2', 'Karin Kuruma (Armored)', 'Bulletproof glass and reinforced panels make this the ultimate getaway vehicle.', 'vehicle', '["armored","bulletproof","essential"]', 3500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/kuruma2.png"]', 'kuruma2', 1),
('veh_insurgent', 'HVY Insurgent', 'A military-grade MRAP that can take rockets and keep rolling. Fear nothing.', 'vehicle', '["military","armored","heavy"]', 6000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/insurgent.png"]', 'insurgent', 0),
('veh_nightshark', 'HVY Nightshark', 'Armored SUV with explosive resistance. The perfect balance of protection and speed.', 'vehicle', '["armored","military","fast"]', 5500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/nightshark.png"]', 'nightshark', 0),
('veh_bati', 'Pegassi Bati 801', 'A Ducati-inspired superbike. Lightning fast and handles like a dream.', 'vehicle', '["motorcycle","fast","racing"]', 1000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/bati.png"]', 'bati', 0),
('veh_hakuchou', 'Shitzu Hakuchou', 'A Suzuki Hayabusa-inspired drag bike. Fastest in a straight line, period.', 'vehicle', '["motorcycle","fast","drag"]', 1500, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/hakuchou.png"]', 'hakuchou', 0),
('veh_deluxo', 'Imponte Deluxo', 'A DeLorean-inspired flying car. Yes, it actually flies. Hover mode included.', 'vehicle', '["special","flying","premium"]', 12000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/deluxo.png"]', 'deluxo', 1),
('veh_toreador', 'Pegassi Toreador', 'A submarine car that transforms between land, water, and even has boost. Ultimate versatility.', 'vehicle', '["special","submarine","boost"]', 10000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/toreador.png"]', 'toreador', 0),
('veh_vigilante', 'Vigilante', 'The Batmobile of GTA. Rocket boost, explosive resistance, and pure intimidation.', 'vehicle', '["special","military","rocket"]', 15000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/vigilante.png"]', 'vigilante', 0),
('veh_scramjet', 'Declasse Scramjet', 'A rocket-powered sports car with a boost and jump ability. Maximum chaos guaranteed.', 'vehicle', '["special","rocket","fun"]', 11000, '["https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/scramjet.png"]', 'scramjet', 0);

INSERT IGNORE INTO `fearx_coinshop_items` (`id`, `name`, `description`, `category`, `tags`, `price`, `images`, `item_name`, `item_count`, `trending`) VALUES
('item_repairkit', 'Vehicle Repair Kit', 'Fix your ride on the spot. No mechanic needed. Contains everything for field repairs.', 'item', '["essential","vehicle","repair"]', 350, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/mechanic/repairkit.png"]', 'repairkit', 3, 0),
('item_medkit', 'First Aid Kit', 'Military-grade first aid kit. Heals you up when the going gets tough.', 'item', '["essential","health","medical"]', 300, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/medical/firstaid_bandage.png"]', 'medikit', 5, 0),
('item_bandage', 'Bandage Pack', 'A bulk pack of 10 bandages. Quick and easy wound treatment in the field.', 'item', '["essential","health","medical"]', 200, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/medical/bandage.png"]', 'bandage', 10, 0),
('item_radio', 'Portable Radio', 'Stay connected with your crew. Encrypted frequency for private comms.', 'item', '["utility","communication"]', 150, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tech/highradio.png"]', 'radio', 1, 0),
('item_burger', 'Bleeder Burger Pack', 'A stack of 10 Bleeder Burgers from Burger Shot. Restores health on consumption.', 'item', '["food","health","bulk"]', 250, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/food/burgershot/burger-bleeder.png"]', 'burger', 10, 0),
('item_sprunk', 'Sprunk Crate', 'A full crate of 15 Sprunk cans. The extreme soda for extreme people.', 'item', '["drink","bulk","popular"]', 200, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/drinks/soda/sprunk.png"]', 'sprunk', 15, 0),
('item_ecola', 'eCola Pack', 'A pack of 10 eCola cans. The delicious taste of Los Santos.', 'item', '["drink","bulk","popular"]', 180, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/drinks/soda/ecola.png"]', 'ecola', 10, 0),
('item_steel', 'Steel Bundle', 'A bundle of 20 high-grade steel. Perfect for crafting and repairs.', 'item', '["material","crafting","bulk"]', 600, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/materials/steel.png"]', 'steel', 20, 0),
('item_rubber', 'Rubber Pack', 'Industrial rubber pack. Used in various crafting recipes.', 'item', '["material","crafting"]', 300, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/materials/rubber.png"]', 'rubber', 15, 0),
('item_copper', 'Copper Wire Bundle', 'High-quality copper wiring for electronic repairs and crafting.', 'item', '["material","crafting","tech"]', 400, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/materials/copper.png"]', 'copper', 15, 0),
('item_aluminum', 'Aluminum Sheets', 'Lightweight aluminum sheets for vehicle and equipment crafting.', 'item', '["material","crafting","metal"]', 450, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/materials/aluminum.png"]', 'aluminum', 10, 0),
('item_iron', 'Iron Ingots', 'Smelted iron ingots ready for forging. A crafting staple.', 'item', '["material","crafting","metal"]', 500, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/materials/iron.png"]', 'iron', 10, 0),
('item_electronics', 'Electronics Kit', 'Assorted circuit boards, wires, and chips. Essential for tech crafting.', 'item', '["material","crafting","tech"]', 800, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/materials/tech_parts.png"]', 'electronic', 10, 1),
('item_tablet', 'Tablet', 'A high-end tablet device. Access the dark web and manage your operations.', 'item', '["tech","utility","premium"]', 1200, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tech/tablet.png"]', 'tablet', 1, 0),
('item_drone', 'Surveillance Drone', 'A compact drone with a camera for aerial reconnaissance.', 'item', '["tech","recon","premium"]', 2000, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tech/drone.png"]', 'drone', 1, 1);

INSERT IGNORE INTO `fearx_coinshop_items` (`id`, `name`, `description`, `category`, `tags`, `price`, `images`, `weapon_name`, `trending`) VALUES
('wep_pistol', 'Combat Pistol', 'A reliable 9mm sidearm. Compact, accurate, and deadly at close range.', 'weapon', '["pistol","sidearm","basic"]', 500, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/pistol/weapon_combatpistol.png"]', 'WEAPON_COMBATPISTOL', 0),
('wep_pistol50', 'Pistol .50', 'A hand cannon that packs a devastating punch. One shot is all it takes.', 'weapon', '["pistol","powerful","premium"]', 800, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/pistol/weapon_pistol50.png"]', 'WEAPON_PISTOL50', 0),
('wep_heavypistol', 'Heavy Pistol', 'A tactical pistol with high stopping power. Favored by professionals.', 'weapon', '["pistol","tactical","heavy"]', 700, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/pistol/weapon_heavypistol.png"]', 'WEAPON_HEAVYPISTOL', 0),
('wep_smg', 'SMG', 'A compact submachine gun perfect for close-quarters combat. High rate of fire.', 'weapon', '["smg","automatic","cqb"]', 1200, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/weapon_smg.png"]', 'WEAPON_SMG', 0),
('wep_combatpdw', 'Combat PDW', 'A personal defense weapon with a built-in grip and excellent accuracy.', 'weapon', '["smg","tactical","compact"]', 1500, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/weapon_combatpdw.png"]', 'WEAPON_COMBATPDW', 0),
('wep_carbine', 'Carbine Rifle', 'The standard-issue assault rifle. Balanced accuracy, damage, and rate of fire.', 'weapon', '["rifle","assault","versatile"]', 2000, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/weapon_carbinerifle.png"]', 'WEAPON_CARBINERIFLE', 1),
('wep_specialcarbine', 'Special Carbine', 'An upgraded assault rifle with better accuracy and a tactical rail system.', 'weapon', '["rifle","assault","tactical"]', 2500, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/weapon_specialcarbine.png"]', 'WEAPON_SPECIALCARBINE', 0),
('wep_advancedrifle', 'Advanced Rifle', 'A bullpup assault rifle with exceptional accuracy and modern design.', 'weapon', '["rifle","assault","advanced"]', 2800, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/weapon_advancedrifle.png"]', 'WEAPON_ADVANCEDRIFLE', 0),
('wep_combatmg', 'Combat MG', 'A belt-fed machine gun that lays down devastating suppressive fire.', 'weapon', '["heavy","mg","suppression"]', 4000, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/weapon_combatmg.png"]', 'WEAPON_COMBATMG', 0),
('wep_minigun', 'Minigun', 'A rotary barrel machine gun with an insane rate of fire. Total destruction.', 'weapon', '["heavy","rare","premium"]', 8000, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/weapon_minigun.png"]', 'WEAPON_MINIGUN', 1),
('wep_sniper', 'Sniper Rifle', 'A bolt-action sniper rifle for long-range engagements. One shot, one kill.', 'weapon', '["sniper","longrange","precision"]', 3000, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/sniper/weapon_sniperrifle.png"]', 'WEAPON_SNIPERRIFLE', 0),
('wep_heavysniper', 'Heavy Sniper', 'An anti-materiel rifle that can punch through armored vehicles. Devastating power.', 'weapon', '["sniper","heavy","premium"]', 5000, '["https://raw.githubusercontent.com/aifazi/items-images/main/weapons/sniper/weapon_heavysniper.png"]', 'WEAPON_HEAVYSNIPER', 0);

INSERT IGNORE INTO `fearx_coinshop_items` (`id`, `name`, `description`, `category`, `tags`, `price`, `images`, `item_name`, `item_count`, `trending`) VALUES
('tool_binoculars', 'Binoculars', 'High-powered military binoculars. See your targets from a safe distance.', 'tool', '["recon","tactical","utility"]', 400, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tools/binoculars.png"]', 'binoculars', 1, 0),
('tool_metaldetector', 'Metal Detector', 'Find buried treasure and hidden valuables. A must-have for treasure hunters.', 'tool', '["treasure","hobby","outdoor"]', 600, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tools/metaldetector.png"]', 'metaldetector', 1, 0),
('tool_safecracker', 'Safe Cracker Kit', 'Professional safe cracking tools. For those high-risk high-reward operations.', 'tool', '["heist","utility","premium"]', 1500, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tools/safecracker.png"]', 'safecracker', 1, 1),
('tool_screwdriver', 'Screwdriver Set', 'A complete set of precision screwdrivers. Essential for any job.', 'tool', '["mechanic","repair","basic"]', 250, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tools/screwdriverset_red.png"]', 'screwdriverset', 1, 0),
('tool_gps', 'GPS Tracker', 'Advanced GPS tracking device. Track vehicles and assets in real-time.', 'tool', '["tech","tracking","utility"]', 800, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tech/garmin-gps.png"]', 'gps', 1, 0),
('tool_handcuffs', 'Handcuffs', 'Professional-grade handcuffs. For those who need to restrain someone temporarily.', 'tool', '["restraint","law","utility"]', 350, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/police/handcuffs.png"]', 'handcuffs', 1, 0),
('tool_nightvision', 'Night Vision Goggles', 'Military-grade NVGs for operating in total darkness. See everything.', 'tool', '["tactical","military","premium"]', 2000, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/tech/nightvision.png"]', 'nightvision', 1, 1),
('tool_bodycam', 'Body Camera', 'Record everything that happens. Perfect evidence for any situation.', 'tool', '["law","recording","utility"]', 500, '["https://raw.githubusercontent.com/McKleans-Scripts/mk-items/main/police/bodycam.png"]', 'bodycam', 1, 0);
