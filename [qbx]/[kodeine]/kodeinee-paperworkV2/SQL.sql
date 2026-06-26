CREATE TABLE IF NOT EXISTS `paperwork` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(100) NOT NULL,
  `first_last` varchar(120) NOT NULL,
  `date` varchar(30) NOT NULL,
  `notes` text NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `paperwork_copies` (
  `citizenid` varchar(100) NOT NULL,
  `last_copy` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
