CREATE TABLE IF NOT EXISTS `uniqers_marriage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) NOT NULL,
  `married` varchar(60) NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `reward_claimed` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `married` (`married`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_engaged` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) NOT NULL,
  `married` varchar(60) NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `married` (`married`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_prepare` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) NOT NULL,
  `married` varchar(60) NOT NULL,
  `playtime` int(11) DEFAULT 0,
  `claimed` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) NOT NULL,
  `married` varchar(60) NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_priests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priest` varchar(60) NOT NULL,
  `totalxp` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1,
  `level_control` longtext DEFAULT NULL,
  `mission` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `priest` (`priest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_cklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_loyalty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `marriage_id` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL,
  `married` varchar(60) NOT NULL,
  `points` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marriage_id_idx` (`marriage_id`),
  KEY `owner_idx` (`owner`),
  KEY `married_idx` (`married`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_mission_cooldowns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(60) NOT NULL,
  `mission_name` varchar(100) NOT NULL,
  `last_completed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizen_mission_idx` (`citizenid`,`mission_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_onetime_completed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(60) NOT NULL,
  `mission_name` varchar(100) NOT NULL,
  `completed_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizen_mission_idx` (`citizenid`,`mission_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_weekly_claims` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `week_id` varchar(20) NOT NULL,
  `marriage_id` int(11) NOT NULL,
  `owner_cid` varchar(60) DEFAULT NULL,
  `married_cid` varchar(60) DEFAULT NULL,
  `points` int(11) DEFAULT 0,
  `rank` int(11) NOT NULL DEFAULT 0,
  `claimed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `week_marriage` (`week_id`,`marriage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `uniqers_marriage_valentines` (
  `owner` varchar(60) NOT NULL,
  `valentine_time` int(11) DEFAULT 0,
  `valentine_tasks` longtext DEFAULT NULL,
  `valentine_photo` varchar(255) DEFAULT NULL,
  `valentine_reward` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `uniqers_marriage_ceremony` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) NOT NULL,
  `married` varchar(60) NOT NULL,
  `c_date` varchar(50) DEFAULT NULL,
  `c_time` varchar(50) DEFAULT NULL,
  `announce` tinyint(1) DEFAULT 0,
  `status` varchar(50) DEFAULT 'pending',
  `surname_choice` varchar(50) DEFAULT 'none',
  `custom_surname` varchar(100) DEFAULT NULL,
  `song_url` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;