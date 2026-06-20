CREATE TABLE `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owneridentifier` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `houseid` int(11) NOT NULL,
  `housetype` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `houseprice` int(11) NOT NULL,
  `rentdata` longtext COLLATE utf8mb4_bin NOT NULL,
  `partofcomplex` tinyint(1) NOT NULL,
  `complex` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `adress` longtext COLLATE utf8mb4_bin NOT NULL,
  `propertyname` longtext COLLATE utf8mb4_bin NOT NULL,
  `description` longtext COLLATE utf8mb4_bin NOT NULL,
  `owned` tinyint(1) NOT NULL DEFAULT '0',
  `housedata` longtext COLLATE utf8mb4_bin NOT NULL,
  `ownername` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `rented` tinyint(1) NOT NULL DEFAULT '0',
  `purchasable` tinyint(1) NOT NULL DEFAULT '1',
  `furniture` longtext COLLATE utf8mb4_bin NOT NULL,
  `permissions` longtext COLLATE utf8mb4_bin NOT NULL,
  `upgrades` longtext COLLATE utf8mb4_bin NOT NULL,
  `tenants` longtext COLLATE utf8mb4_bin NOT NULL,
  `visitorlog` longtext COLLATE utf8mb4_bin NOT NULL,
  `deliveries` longtext COLLATE utf8mb4_bin NOT NULL,
  `settings` longtext COLLATE utf8mb4_bin NOT NULL,
  `services` longtext COLLATE utf8mb4_bin NOT NULL,
  `bills` longtext COLLATE utf8mb4_bin NOT NULL,
  `housekeys` longtext COLLATE utf8mb4_bin NOT NULL,
  `images` longtext COLLATE utf8mb4_bin NOT NULL,
  `list` longtext COLLATE utf8mb4_bin NOT NULL,
  `cleanpoints` longtext COLLATE utf8mb4_bin NOT NULL,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `lastproperty` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(500) COLLATE utf8mb4_bin NOT NULL,
  `houseid` INT(11) NOT NULL DEFAULT 0,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_identifier` (`identifier`(191)),
  KEY `idx_houseid` (`houseid`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_bin;


ALTER TABLE houses ADD INDEX (houseid);