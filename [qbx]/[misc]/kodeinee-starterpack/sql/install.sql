CREATE TABLE IF NOT EXISTS `kodeinee_starterpack_claims` (
    `identifier` VARCHAR(100) NOT NULL,
    `pack` VARCHAR(30) NOT NULL DEFAULT 'starterpack',
    `claimed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`identifier`, `pack`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
