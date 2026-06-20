-- Idempotent: every CREATE uses IF NOT EXISTS. Schema migrations for existing
-- installs live in `migrations.sql` and run after this file.
--
-- Statement order matters on a fresh DB: parent tables MUST be created before
-- any child table that references them via foreign key. Order below is:
--   nex_hotels
--   └── nex_hotel_rooms          (FK -> nex_hotels)
--   └── nex_hotel_elevators      (FK -> nex_hotels)
--        └── nex_hotel_elevator_stops (FK -> nex_hotel_elevators)
--   └── nex_hotel_rentals        (FK -> nex_hotels + nex_hotel_rooms)
--       └── nex_hotel_room_keys  (FK -> nex_hotel_rentals)

CREATE TABLE IF NOT EXISTS `nex_hotels` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(96) NOT NULL,
    `description` TEXT NULL,
    `image` VARCHAR(512) NULL,
    `room_description` TEXT NULL,
    `room_image` VARCHAR(512) NULL,
    `blip` JSON NULL,
    `entrance_x` FLOAT NOT NULL,
    `entrance_y` FLOAT NOT NULL,
    `entrance_z` FLOAT NOT NULL,
    `entrance_h` FLOAT NOT NULL DEFAULT 0,
    `exit_x` FLOAT NOT NULL,
    `exit_y` FLOAT NOT NULL,
    `exit_z` FLOAT NOT NULL,
    `exit_h` FLOAT NOT NULL DEFAULT 0,
    `retail_price` INT UNSIGNED NOT NULL DEFAULT 0,
    `ped` JSON NULL,
    `interior_type` VARCHAR(8) NULL,
    `interior_loading` JSON NULL,
    `owner_identifier` VARCHAR(96) NULL,
    `owner_name` VARCHAR(96) NULL,
    `job_name` VARCHAR(64) NULL,
    `purchased_at` DATETIME NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_name` (`name`),
    KEY `idx_owner` (`owner_identifier`),
    KEY `idx_job` (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nex_hotel_rooms` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hotel_id` INT UNSIGNED NOT NULL,
    `floor_number` INT UNSIGNED NOT NULL DEFAULT 1,
    `room_number` INT UNSIGNED NOT NULL DEFAULT 1,
    `label` VARCHAR(64) NOT NULL,
    `price` INT UNSIGNED NOT NULL DEFAULT 0,
    `unlock_price` INT UNSIGNED NOT NULL DEFAULT 0,
    `entry_x` FLOAT NOT NULL,
    `entry_y` FLOAT NOT NULL,
    `entry_z` FLOAT NOT NULL,
    `entry_h` FLOAT NOT NULL DEFAULT 0,
    `interior_x` FLOAT NULL,
    `interior_y` FLOAT NULL,
    `interior_z` FLOAT NULL,
    `interior_h` FLOAT NULL DEFAULT 0,
    `range` INT UNSIGNED NOT NULL DEFAULT 12,
    `door_object` JSON NULL,
    `storage_x` FLOAT NULL,  `storage_y` FLOAT NULL,  `storage_z` FLOAT NULL,
    `clothing_x` FLOAT NULL, `clothing_y` FLOAT NULL, `clothing_z` FLOAT NULL,
    `safe_x` FLOAT NULL,     `safe_y` FLOAT NULL,     `safe_z` FLOAT NULL,
    `minibar_x` FLOAT NULL,  `minibar_y` FLOAT NULL,  `minibar_z` FLOAT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_room` (`hotel_id`, `floor_number`, `room_number`),
    CONSTRAINT `fk_hotel` FOREIGN KEY (`hotel_id`) REFERENCES `nex_hotels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nex_hotel_elevators` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hotel_id` INT UNSIGNED NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_elev_hotel` (`hotel_id`),
    CONSTRAINT `fk_elev_hotel` FOREIGN KEY (`hotel_id`) REFERENCES `nex_hotels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nex_hotel_elevator_stops` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `elevator_id` INT UNSIGNED NOT NULL,
    `label` VARCHAR(64) NOT NULL,
    `sort_order` INT UNSIGNED NOT NULL DEFAULT 0,
    `x` FLOAT NOT NULL,
    `y` FLOAT NOT NULL,
    `z` FLOAT NOT NULL,
    `h` FLOAT NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `fk_stop_elev` (`elevator_id`),
    CONSTRAINT `fk_stop_elev` FOREIGN KEY (`elevator_id`) REFERENCES `nex_hotel_elevators` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nex_hotel_rentals` (
    `hotel_id` INT UNSIGNED NOT NULL,
    `room_id` INT UNSIGNED NOT NULL,
    `owner_identifier` VARCHAR(96) NOT NULL,
    `rented_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `expires_at` DATETIME NULL,
    PRIMARY KEY (`hotel_id`, `room_id`),
    KEY `idx_owner_per_hotel` (`hotel_id`, `owner_identifier`),
    CONSTRAINT `fk_rent_hotel` FOREIGN KEY (`hotel_id`) REFERENCES `nex_hotels` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_rent_room`  FOREIGN KEY (`room_id`)  REFERENCES `nex_hotel_rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nex_hotel_room_keys` (
    `hotel_id` INT UNSIGNED NOT NULL,
    `room_id` INT UNSIGNED NOT NULL,
    `holder_identifier` VARCHAR(96) NOT NULL,
    `holder_name` VARCHAR(96) NULL,
    `granted_by` VARCHAR(96) NOT NULL,
    `granted_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`hotel_id`, `room_id`, `holder_identifier`),
    KEY `idx_holder_per_hotel` (`hotel_id`, `holder_identifier`),
    CONSTRAINT `fk_key_rental` FOREIGN KEY (`hotel_id`, `room_id`) REFERENCES `nex_hotel_rentals` (`hotel_id`, `room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
