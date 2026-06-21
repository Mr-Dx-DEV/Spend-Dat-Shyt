INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('condom', 'Condom', 100),
	('levonorgestrel', 'Levonorgestrel', 100),
	('mifepristone', 'Mifepristone', 100),
	('testpack', 'Test Pack', 100),
	('viagra', 'Viagra', 100)
;

CREATE TABLE IF NOT EXISTS `last_pregnant` (
  `identifier` varchar(255) NOT NULL,
  `pregnant_time` int(255) DEFAULT 0,
  `pregnant_estimate` int(255) DEFAULT 0,
  `dna` varchar(255) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

ALTER TABLE `users`
	ADD `diseasesex` LONGTEXT NOT NULL DEFAULT 'cured',
	ADD `mypartnersex` LONGTEXT NOT NULL DEFAULT 'none',
	ADD `bodycount` INT(255) DEFAULT 0
;

-- update from v3

-- drop pregnant column
ALTER TABLE `last_pregnant`
DROP COLUMN `pregnant`;
-- change default value for dna table
ALTER TABLE `last_pregnant`
MODIFY COLUMN `dna` VARCHAR(255) DEFAULT 'Unknown';
-- change exist value from empty to Unknown
UPDATE `last_pregnant` SET `dna` = 'Unknown';
-- add bodycount column
ALTER TABLE `users`
    ADD `bodycount` INT(255) DEFAULT 0
;