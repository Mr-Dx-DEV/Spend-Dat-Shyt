CREATE TABLE IF NOT EXISTS `codewave_techworkz` (
    `id`             INT          NOT NULL AUTO_INCREMENT,
    `identifier`     VARCHAR(60)  NOT NULL,
    `xp`             INT          NOT NULL DEFAULT 0,
    `level`          INT          NOT NULL DEFAULT 1,
    `total_sales`    INT          NOT NULL DEFAULT 0,
    `specialisation` VARCHAR(50)  DEFAULT NULL,
    `spec_set_at`    INT          DEFAULT NULL,
    `created_at`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
