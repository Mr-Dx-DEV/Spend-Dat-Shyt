-- ============================================================================
-- Orbit OnlyPics v2.0.0 — Database Setup
-- ============================================================================
-- Run this in your MySQL database (HeidiSQL, phpMyAdmin, DBeaver, etc.)
--
-- NOTE: If you're upgrading from v1.x, the server will AUTOMATICALLY migrate
-- your existing baddie_stats table on first boot. You can still run this SQL
-- manually if you prefer — it uses IF NOT EXISTS so it's safe either way.
-- ============================================================================

-- Main stats table (holds sales, XP, rank, followers, viral photo count)
CREATE TABLE IF NOT EXISTS `baddie_stats` (
  `identifier` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sales` int(11) NOT NULL DEFAULT 0,
  `bundle_sales` int(11) NOT NULL DEFAULT 0,
  `total_earned` int(11) NOT NULL DEFAULT 0,
  `xp` int(11) NOT NULL DEFAULT 0,
  `rank` int(11) NOT NULL DEFAULT 1,
  `followers` int(11) NOT NULL DEFAULT 0,
  `viral_photos` int(11) NOT NULL DEFAULT 0,
  `bp_phone_unlocked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daily + weekly challenges per player
CREATE TABLE IF NOT EXISTS `baddie_challenges` (
  `identifier` varchar(50) NOT NULL,
  `challenge_id` varchar(50) NOT NULL,
  `progress` int(11) NOT NULL DEFAULT 0,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `claimed` tinyint(1) NOT NULL DEFAULT 0,
  `reset_type` enum('daily','weekly') NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`identifier`, `challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Permanent achievements unlocked per player
CREATE TABLE IF NOT EXISTS `baddie_achievements` (
  `identifier` varchar(50) NOT NULL,
  `achievement_id` varchar(50) NOT NULL,
  `unlocked_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `claimed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`, `achievement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tracks which locations each player has sold photos at (for World Tour achievement)
CREATE TABLE IF NOT EXISTS `baddie_locations` (
  `identifier` varchar(50) NOT NULL,
  `location_id` varchar(50) NOT NULL,
  `sales_count` int(11) NOT NULL DEFAULT 0,
  `discovered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`identifier`, `location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- V1 → V2 MIGRATION (only runs if upgrading)
-- These ALTER statements add missing columns to existing v1 tables.
-- If you're on a fresh install the CREATE TABLE above handles everything.
-- ============================================================================
-- Uncomment if auto-migration fails for some reason:
--
-- ALTER TABLE `baddie_stats` ADD COLUMN IF NOT EXISTS `bundle_sales` int(11) NOT NULL DEFAULT 0;
-- ALTER TABLE `baddie_stats` ADD COLUMN IF NOT EXISTS `total_earned` int(11) NOT NULL DEFAULT 0;
-- ALTER TABLE `baddie_stats` ADD COLUMN IF NOT EXISTS `xp` int(11) NOT NULL DEFAULT 0;
-- ALTER TABLE `baddie_stats` ADD COLUMN IF NOT EXISTS `rank` int(11) NOT NULL DEFAULT 1;
-- ALTER TABLE `baddie_stats` ADD COLUMN IF NOT EXISTS `followers` int(11) NOT NULL DEFAULT 0;
-- ALTER TABLE `baddie_stats` ADD COLUMN IF NOT EXISTS `viral_photos` int(11) NOT NULL DEFAULT 0;
-- ALTER TABLE `baddie_stats` ADD COLUMN IF NOT EXISTS `bp_phone_unlocked` tinyint(1) NOT NULL DEFAULT 0;
-- ============================================================================
-- 📱 BADDIE PHONE — accounts + uploaded photos (v2.0.2)
-- ============================================================================

-- One social account per character/identifier
CREATE TABLE IF NOT EXISTS `baddie_phone_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(64) NOT NULL,
  `username` varchar(32) NOT NULL,
  `display_name` varchar(48) NOT NULL,
  `password` varchar(128) NOT NULL,
  `bio` varchar(255) NOT NULL DEFAULT '',
  `avatar` text DEFAULT NULL,
  `followers` int(11) NOT NULL DEFAULT 0,
  `total_earned` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Photos captured/uploaded inside the app
CREATE TABLE IF NOT EXISTS `baddie_phone_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `url` text NOT NULL,
  `caption` varchar(160) NOT NULL DEFAULT '',
  `uploaded` tinyint(1) NOT NULL DEFAULT 0,   -- 0 = gallery only, 1 = posted/public
  `viral` tinyint(1) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `likes` int(11) NOT NULL DEFAULT 0,
  `earned` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,      -- still gaining views
  `created_at` int(11) NOT NULL DEFAULT 0,
  `posted_at` int(11) NOT NULL DEFAULT 0,
  `expires_at` int(11) NOT NULL DEFAULT 0,     -- when it stops earning
  `last_tick` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `uploaded_active` (`uploaded`, `active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
