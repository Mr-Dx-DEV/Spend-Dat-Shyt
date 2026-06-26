CREATE TABLE IF NOT EXISTS `striker_lockouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(20) NOT NULL,
  `clone_plate` varchar(20) DEFAULT NULL,
  `owner_citizenid` varchar(80) NOT NULL,
  `thief_citizenid` varchar(80) NOT NULL,
  `expires_at` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `vehicle_props` longtext DEFAULT NULL,
  `is_chopped` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_plate` (`plate`),
  KEY `idx_clone_plate` (`clone_plate`),
  KEY `idx_owner` (`owner_citizenid`),
  KEY `idx_thief` (`thief_citizenid`),
  KEY `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `strikerpad_usage` (
  `citizenid` varchar(80) NOT NULL,
  `uses` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
