-- Schema migrations for existing installs. Each statement uses
-- `IF NOT EXISTS` / `IF EXISTS` so it's safe to run on every boot.
-- (Requires MariaDB 10.0.2+ or MySQL 8.0.29+.)

ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `description` TEXT NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `image` VARCHAR(512) NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `room_description` TEXT NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `room_image` VARCHAR(512) NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `retail_price` INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `ped` JSON NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `interior_type` VARCHAR(8) NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `interior_loading` JSON NULL;

-- v1.1: per-player hotel ownership + job-locked management
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `owner_identifier` VARCHAR(96) NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `owner_name` VARCHAR(96) NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `job_name` VARCHAR(64) NULL;
ALTER TABLE `nex_hotels` ADD COLUMN IF NOT EXISTS `purchased_at` DATETIME NULL;
ALTER TABLE `nex_hotels` ADD INDEX IF NOT EXISTS `idx_owner` (`owner_identifier`);
ALTER TABLE `nex_hotels` ADD INDEX IF NOT EXISTS `idx_job` (`job_name`);

-- Rename old `door_*` columns from the v0.1 schema to `entry_*`
ALTER TABLE `nex_hotel_rooms` CHANGE COLUMN IF EXISTS `door_x` `entry_x` FLOAT NOT NULL;
ALTER TABLE `nex_hotel_rooms` CHANGE COLUMN IF EXISTS `door_y` `entry_y` FLOAT NOT NULL;
ALTER TABLE `nex_hotel_rooms` CHANGE COLUMN IF EXISTS `door_z` `entry_z` FLOAT NOT NULL;
ALTER TABLE `nex_hotel_rooms` CHANGE COLUMN IF EXISTS `door_h` `entry_h` FLOAT NOT NULL DEFAULT 0;

ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `floor_number` INT UNSIGNED NOT NULL DEFAULT 1;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `room_number` INT UNSIGNED NOT NULL DEFAULT 1;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `unlock_price` INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `interior_x` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `interior_y` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `interior_z` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `interior_h` FLOAT NULL DEFAULT 0;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `range` INT UNSIGNED NOT NULL DEFAULT 12;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `door_object` JSON NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `storage_x` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `storage_y` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `storage_z` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `clothing_x` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `clothing_y` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `clothing_z` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `safe_x` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `safe_y` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `safe_z` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `minibar_x` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `minibar_y` FLOAT NULL;
ALTER TABLE `nex_hotel_rooms` ADD COLUMN IF NOT EXISTS `minibar_z` FLOAT NULL;

-- v0.5: allow multiple rentals per character (one per hotel) — drop the global
-- per-owner UNIQUE constraint and replace with a per-hotel one.
ALTER TABLE `nex_hotel_rentals` DROP INDEX `uniq_owner`;
ALTER TABLE `nex_hotel_rentals` ADD UNIQUE KEY `uniq_owner_per_hotel` (`hotel_id`, `owner_identifier`);

-- Persistent rentals (added in v0.4) — survives server restart + player reconnect.
CREATE TABLE IF NOT EXISTS `nex_hotel_rentals` (
    `hotel_id` INT UNSIGNED NOT NULL,
    `room_id` INT UNSIGNED NOT NULL,
    `owner_identifier` VARCHAR(96) NOT NULL,
    `rented_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `expires_at` DATETIME NULL,
    PRIMARY KEY (`hotel_id`, `room_id`),
    UNIQUE KEY `uniq_owner` (`owner_identifier`),
    CONSTRAINT `fk_rent_hotel` FOREIGN KEY (`hotel_id`) REFERENCES `nex_hotels` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_rent_room`  FOREIGN KEY (`room_id`)  REFERENCES `nex_hotel_rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Room keys granted by renters. Keys are tied to the active rental, so checkout,
-- expiry, and room/hotel deletion remove them automatically in the DB.
CREATE TABLE IF NOT EXISTS `nex_hotel_room_keys` (
    `hotel_id` INT UNSIGNED NOT NULL,
    `room_id` INT UNSIGNED NOT NULL,
    `holder_identifier` VARCHAR(96) NOT NULL,
    `holder_name` VARCHAR(96) NULL,
    `granted_by` VARCHAR(96) NOT NULL,
    `granted_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`hotel_id`, `room_id`, `holder_identifier`),
    UNIQUE KEY `uniq_holder_per_hotel` (`hotel_id`, `holder_identifier`),
    CONSTRAINT `fk_key_rental` FOREIGN KEY (`hotel_id`, `room_id`) REFERENCES `nex_hotel_rentals` (`hotel_id`, `room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Multi-room: allow MULTIPLE rooms per character in the SAME hotel
-- (Config.RentLimits.PerHotel). Drop the per-hotel UNIQUE constraints that pinned a
-- character to one room / one key per hotel; replace with plain lookup indexes.
ALTER TABLE `nex_hotel_rentals`   DROP INDEX IF EXISTS `uniq_owner_per_hotel`;
ALTER TABLE `nex_hotel_rentals`   ADD INDEX  IF NOT EXISTS `idx_owner_per_hotel`  (`hotel_id`, `owner_identifier`);
ALTER TABLE `nex_hotel_room_keys` DROP INDEX IF EXISTS `uniq_holder_per_hotel`;
ALTER TABLE `nex_hotel_room_keys` ADD INDEX  IF NOT EXISTS `idx_holder_per_hotel` (`hotel_id`, `holder_identifier`);

-- Elevator tables (added in v0.3) — CREATE IF NOT EXISTS is idempotent.
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
