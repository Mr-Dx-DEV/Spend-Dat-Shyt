CREATE TABLE IF NOT EXISTS `g_multijob` (
    `identifier` VARCHAR(64) NOT NULL,
    `job` VARCHAR(50) NOT NULL,
    `grade` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`identifier`, `job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
