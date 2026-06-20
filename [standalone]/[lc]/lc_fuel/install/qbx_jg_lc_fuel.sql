-- Optional helper for QBX/Qbox servers using LC Fuel with JG Garages / JG Advanced Garages.
-- JG stores vehicle fuel level in player_vehicles.fuel.
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `fuel` INT(10) DEFAULT '100';

-- LC Fuel stores persistent fuel type separately.
CREATE TABLE IF NOT EXISTS `player_vehicles_fuel_type` (
    `plate` VARCHAR(20) NOT NULL COLLATE 'utf8_general_ci',
    `fuelType` VARCHAR(20) NOT NULL COLLATE 'utf8_general_ci',
    PRIMARY KEY (`plate`) USING BTREE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;
