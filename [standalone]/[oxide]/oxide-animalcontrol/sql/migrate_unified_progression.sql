-- ============================================================================
-- Migration: Unified Job Progression Table
-- Merges all per-job progression tables into a single `job_progression` table.
-- Safe to run multiple times — uses IF EXISTS guards for every source table.
-- Run this ONCE across all your Oxide job resources.
-- ============================================================================

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS _migrate_job_progression()
BEGIN

    -- 1. Create the unified table if it doesn't exist
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

    -- 2. Migrate each old table (if it exists) then drop it

    -- Pizza Job
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'pizzajob_progression') THEN
        -- Drop FK if it exists (may have been removed by prior migration)
        IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_schema = DATABASE() AND table_name = 'pizzajob_progression' AND constraint_name = 'fk_pizzajob_character') THEN
            ALTER TABLE `pizzajob_progression` DROP FOREIGN KEY `fk_pizzajob_character`;
        END IF;
        INSERT IGNORE INTO `job_progression` (`char_id`, `job`, `level`, `total_count`, `daily_streak`, `last_activity_date`, `complaints`, `timeout_until`)
            SELECT CAST(`char_id` AS CHAR(60)), 'pizza', `level`, `total_deliveries`, `daily_streak`, `last_delivery_date`, `complaints`, `timeout_until`
            FROM `pizzajob_progression`;
        DROP TABLE `pizzajob_progression`;
    END IF;

    -- Postal Job
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'postaljob_progression') THEN
        IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_schema = DATABASE() AND table_name = 'postaljob_progression' AND constraint_name = 'fk_postaljob_character') THEN
            ALTER TABLE `postaljob_progression` DROP FOREIGN KEY `fk_postaljob_character`;
        END IF;
        INSERT IGNORE INTO `job_progression` (`char_id`, `job`, `level`, `total_count`, `daily_streak`, `last_activity_date`, `complaints`, `timeout_until`)
            SELECT `char_id`, 'postal', `level`, `total_deliveries`, `daily_streak`, `last_delivery_date`, `complaints`, `timeout_until`
            FROM `postaljob_progression`;
        DROP TABLE `postaljob_progression`;
    END IF;

    -- Landscaping Job
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'landscapingjob_progression') THEN
        IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_schema = DATABASE() AND table_name = 'landscapingjob_progression' AND constraint_name = 'fk_landscapingjob_character') THEN
            ALTER TABLE `landscapingjob_progression` DROP FOREIGN KEY `fk_landscapingjob_character`;
        END IF;
        INSERT IGNORE INTO `job_progression` (`char_id`, `job`, `level`, `total_count`, `daily_streak`, `last_activity_date`, `complaints`, `timeout_until`)
            SELECT `char_id`, 'landscaping', `level`, `total_yards`, `daily_streak`, `last_yard_date`, `complaints`, `timeout_until`
            FROM `landscapingjob_progression`;
        DROP TABLE `landscapingjob_progression`;
    END IF;

    -- Animal Control Job
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'animalcontroljob_progression') THEN
        IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_schema = DATABASE() AND table_name = 'animalcontroljob_progression' AND constraint_name = 'fk_animalcontroljob_character') THEN
            ALTER TABLE `animalcontroljob_progression` DROP FOREIGN KEY `fk_animalcontroljob_character`;
        END IF;
        INSERT IGNORE INTO `job_progression` (`char_id`, `job`, `level`, `total_count`, `daily_streak`, `last_activity_date`, `complaints`, `timeout_until`)
            SELECT `char_id`, 'animalcontrol', `level`, `total_jobs`, `daily_streak`, `last_job_date`, `complaints`, `timeout_until`
            FROM `animalcontroljob_progression`;
        DROP TABLE `animalcontroljob_progression`;
    END IF;

    -- Newspaper Job
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'newspaperjob_progression') THEN
        IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_schema = DATABASE() AND table_name = 'newspaperjob_progression' AND constraint_name = 'fk_newspaperjob_character') THEN
            ALTER TABLE `newspaperjob_progression` DROP FOREIGN KEY `fk_newspaperjob_character`;
        END IF;
        INSERT IGNORE INTO `job_progression` (`char_id`, `job`, `level`, `total_count`, `daily_streak`, `last_activity_date`, `complaints`, `timeout_until`)
            SELECT `char_id`, 'newspaper', `level`, `total_deliveries`, `daily_streak`, `last_delivery_date`, `complaints`, `timeout_until`
            FROM `newspaperjob_progression`;
        DROP TABLE `newspaperjob_progression`;
    END IF;

    -- Roadside Assistance Job
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'roadsideassistancejob_progression') THEN
        IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_schema = DATABASE() AND table_name = 'roadsideassistancejob_progression' AND constraint_name = 'fk_roadsideassistancejob_character') THEN
            ALTER TABLE `roadsideassistancejob_progression` DROP FOREIGN KEY `fk_roadsideassistancejob_character`;
        END IF;
        INSERT IGNORE INTO `job_progression` (`char_id`, `job`, `level`, `total_count`, `daily_streak`, `last_activity_date`, `complaints`, `timeout_until`)
            SELECT `char_id`, 'roadside', `level`, `total_jobs`, `daily_streak`, `last_job_date`, `complaints`, `timeout_until`
            FROM `roadsideassistancejob_progression`;
        DROP TABLE `roadsideassistancejob_progression`;
    END IF;

END //

DELIMITER ;

CALL _migrate_job_progression();
DROP PROCEDURE IF EXISTS _migrate_job_progression;
