-- The resource installs this schema automatically on first start. This file
-- exists for ops who prefer to pre-seed. If upgrading from older versions, run:
-- ALTER TABLE fearx_moneywash MODIFY COLUMN status ENUM('active','completed','paying','withdrawn','refunded','cancelled','orphaned') NOT NULL DEFAULT 'active';
-- ALTER TABLE fearx_moneywash ADD COLUMN washpoint_id INT NOT NULL DEFAULT 0;
-- ALTER TABLE fearx_moneywash ADD COLUMN paid_at BIGINT NULL DEFAULT NULL;
-- ALTER TABLE fearx_moneywash ADD INDEX idx_location_point_status (location_id, washpoint_id, status);

CREATE TABLE IF NOT EXISTS `fearx_moneywash` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(60) NOT NULL,
    `dirty_amount` INT NOT NULL,
    `clean_amount` INT NOT NULL,
    `started_at` BIGINT NOT NULL,
    `finishes_at` BIGINT NOT NULL,
    `status` ENUM('active','completed','paying','withdrawn','refunded','cancelled','orphaned') NOT NULL DEFAULT 'active',
    `location_id` INT NOT NULL DEFAULT 1,
    `washpoint_id` INT NOT NULL DEFAULT 0,
    `paid_at` BIGINT NULL DEFAULT NULL,
    INDEX `idx_identifier_status` (`identifier`, `status`),
    INDEX `idx_status_finishes` (`status`, `finishes_at`),
    INDEX `idx_location_point_status` (`location_id`, `washpoint_id`, `status`)
);
