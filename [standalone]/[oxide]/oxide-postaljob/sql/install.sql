CREATE TABLE IF NOT EXISTS `job_progression` (
    `char_id`            VARCHAR(60)      NOT NULL,
    `job`                VARCHAR(40)      NOT NULL,
    `level`              TINYINT          NOT NULL DEFAULT 1,
    `total_count`        INT              NOT NULL DEFAULT 0,
    `daily_streak`       INT              NOT NULL DEFAULT 0,
    `last_activity_date` DATE             NULL,
    `complaints`         TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `timeout_until`      DATETIME         NULL,
    PRIMARY KEY (`char_id`, `job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
