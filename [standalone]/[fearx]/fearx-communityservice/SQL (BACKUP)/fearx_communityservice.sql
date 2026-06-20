CREATE TABLE IF NOT EXISTS `fearx_communityservice` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(100) NOT NULL,
    `discord_id` VARCHAR(100),
    `amount` INT NOT NULL,
    `completed` INT NOT NULL DEFAULT 0,
    `admin` VARCHAR(255) NOT NULL,
    `admin_discord` VARCHAR(100),
    `reason` TEXT,
    `return_coords` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
