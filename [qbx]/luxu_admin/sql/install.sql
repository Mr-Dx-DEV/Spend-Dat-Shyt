CREATE TABLE IF NOT EXISTS `luxu_admin_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `discord_role_id` varchar(20) DEFAULT NULL,
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `permissions` longtext NOT NULL,
  `ace_config` longtext NOT NULL,
  `clothing` longtext DEFAULT NULL,
  `sprite` longtext DEFAULT NULL,
  `gamertag_color` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `discord_role_id` (`discord_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_group_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) DEFAULT NULL,
  `group` varchar(255) NOT NULL,
  `license2` varchar(255) DEFAULT NULL,
  `fivem` varchar(255) DEFAULT NULL,
  `discord` varchar(255) DEFAULT NULL,
  `steam` varchar(255) DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `current_duty_start` datetime DEFAULT NULL,
  `total_duty_seconds` int(10) unsigned NOT NULL DEFAULT 0,
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `license2` (`license2`),
  UNIQUE KEY `fivem` (`fivem`),
  UNIQUE KEY `discord` (`discord`),
  UNIQUE KEY `steam` (`steam`),
  KEY `group_name` (`group`),
   CONSTRAINT `group_name` FOREIGN KEY (`group`) REFERENCES `luxu_admin_groups` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_blips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `coords` longtext NOT NULL,
  `display` int(10) unsigned NOT NULL,
  `scale` float NOT NULL,
  `shortRange` tinyint(1) NOT NULL,
  `color` int(10) unsigned NOT NULL,
  `sprite` int(10) unsigned NOT NULL,
  `category` varchar(100) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_chats` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL DEFAULT 0,
  `is_report` tinyint(1) NOT NULL DEFAULT 0,
  `is_closed` tinyint(1) NOT NULL DEFAULT 0,
  `staff_restrictions` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `claimed_by` int(10) unsigned DEFAULT NULL,
  `claimed_by_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_luxu_admin_chats_luxu_admin_group_members` (`claimed_by`),
  CONSTRAINT `FK_luxu_admin_chats_luxu_admin_group_members` FOREIGN KEY (`claimed_by`) REFERENCES `luxu_admin_group_members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `date` datetime NOT NULL,
  `author_id` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `luxu_admin_media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('image','video','audio') NOT NULL,
  `cdn_id` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `expiration` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `author_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(64) NOT NULL,
  `data` longtext NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_type_created_at` (`type`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_player_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `staff_name` varchar(255) NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_props` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `model` varchar(255) NOT NULL,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `rx` float NOT NULL DEFAULT 0,
  `ry` float NOT NULL DEFAULT 0,
  `rz` float NOT NULL DEFAULT 0,
  `plate` varchar(8) NOT NULL DEFAULT '',
  `metadata` longtext NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `type` enum('vehicle','object','ped') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_jail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` varchar(255) NOT NULL,
  `char_name` varchar(255) NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `staff_name` varchar(255) NOT NULL,
  `reason` text NOT NULL DEFAULT '',
  `cell_name` varchar(255) DEFAULT NULL,
  `last_coords` longtext NOT NULL,
  `bucket` int(10) unsigned NOT NULL DEFAULT 0,
  `time_mode` enum('date','playtime') NOT NULL DEFAULT 'date',
  `duration_ms` bigint(20) unsigned NOT NULL DEFAULT 0,
  `remaining_ms` bigint(20) unsigned NOT NULL DEFAULT 0,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `char_id` (`char_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `points` longtext NOT NULL,
  `height` int(10) unsigned NOT NULL DEFAULT 0,
  `metadata` longtext NOT NULL,
  `rgba` longtext NOT NULL,
  `debug` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `customHandler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_name` varchar(255) NOT NULL,
  `player_id` varchar(255) NOT NULL,
  `identifiers` longtext NOT NULL,
  `tokens` longtext NOT NULL,
  `reason` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `FK_luxu_admin_bans_luxu_admin_group_members` (`staff_id`),
  CONSTRAINT `FK_luxu_admin_bans_luxu_admin_group_members` FOREIGN KEY (`staff_id`) REFERENCES `luxu_admin_group_members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_chat_messages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` int(11) unsigned NOT NULL,
  `author_id` varchar(255) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `attachments` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_chat_messages_chat_id` (`chat_id`),
  CONSTRAINT `fk_chat_messages_chat` FOREIGN KEY (`chat_id`) REFERENCES `luxu_admin_chats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_warnings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_name` varchar(255) NOT NULL,
  `player_id` varchar(255) NOT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `FK_luxu_admin_warnings_luxu_admin_group_members` FOREIGN KEY (`staff_id`) REFERENCES `luxu_admin_group_members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_duty_sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL,
  `start_time` datetime NOT NULL DEFAULT current_timestamp(),
  `end_time` datetime DEFAULT NULL,
  `duration_seconds` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_staff_active_sessions` (`staff_id`,`end_time`,`start_time` DESC),
  KEY `idx_staff_start_time` (`staff_id`,`start_time` DESC),
  KEY `idx_end_time_start_time` (`end_time`,`start_time`),
  KEY `idx_staff_duration` (`staff_id`,`duration_seconds`),
  CONSTRAINT `fk_duty_sessions_staff` FOREIGN KEY (`staff_id`) REFERENCES `luxu_admin_group_members` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_duty_daily_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `total_seconds` int(10) unsigned NOT NULL DEFAULT 0,
  `session_count` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_staff_date` (`staff_id`,`date`),
  KEY `idx_date` (`date`),
  KEY `idx_staff_date_totals` (`staff_id`,`date`,`total_seconds`),
  KEY `idx_date_staff_totals` (`date`,`staff_id`,`total_seconds` DESC),
  CONSTRAINT `fk_duty_daily_stats_staff` FOREIGN KEY (`staff_id`) REFERENCES `luxu_admin_group_members` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_staff_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `staff_name` varchar(255) NOT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `target_type` varchar(50) DEFAULT NULL,
  `target_id` varchar(255) DEFAULT NULL,
  `target_name` varchar(255) DEFAULT NULL,
  `metadata` longtext NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_staff_created` (`staff_id`, `created_at` DESC),
  KEY `idx_permission_created` (`permission`, `created_at` DESC),
  KEY `idx_action_created` (`action`, `created_at` DESC),
  KEY `idx_target_created` (`target_type`, `target_id`, `created_at` DESC),
  KEY `idx_created` (`created_at` DESC),
  CONSTRAINT `fk_staff_logs_staff` FOREIGN KEY (`staff_id`) REFERENCES `luxu_admin_group_members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_player_coords_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` varchar(255) NOT NULL,
  `ts` bigint(20) unsigned NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_player_ts` (`player_id`, `ts`),
  KEY `idx_player_ts` (`player_id`, `ts`),
  KEY `idx_ts` (`ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `luxu_admin_player_coords_meta` (
  `player_id` varchar(255) NOT NULL,
  `last_seen` bigint(20) unsigned NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `last_x` float NOT NULL,
  `last_y` float NOT NULL,
  PRIMARY KEY (`player_id`),
  KEY `idx_last_seen` (`last_seen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
