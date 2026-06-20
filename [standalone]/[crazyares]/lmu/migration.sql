-- ─────────────────────────────────────────────────────────────────────────────
--  grim_lovemenu — Database Migration v2.2.0
--  Run once against your server database.
--  Safe to re-run: all tables use CREATE TABLE IF NOT EXISTS
-- ─────────────────────────────────────────────────────────────────────────────

-- ── PREGNANCY ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_pregnancy` (
    `id`           INT UNSIGNED       NOT NULL AUTO_INCREMENT,
    `cid`          VARCHAR(64)        NOT NULL,
    `partner_cid`  VARCHAR(64)        NOT NULL DEFAULT '',
    `conceived_at` DATETIME           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `birth_at`     DATETIME           NOT NULL,
    `gender`       ENUM('boy','girl') NOT NULL DEFAULT 'girl',
    `born`         TINYINT(1)         NOT NULL DEFAULT 0,
    `preg_stage`   VARCHAR(32)        NOT NULL DEFAULT 'early',
    PRIMARY KEY (`id`),
    INDEX `idx_cid`(`cid`),
    INDEX `idx_born`(`born`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `grim_lm_baby_profiles` (
    `id`                       INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `pregnancy_id`             INT UNSIGNED NULL,
    `child_id`                 VARCHAR(64)  NOT NULL,
    `mother_citizenid`         VARCHAR(64)  NOT NULL,
    `father_citizenid`         VARCHAR(64)  NOT NULL DEFAULT '',
    `mother_name`              VARCHAR(128) NOT NULL DEFAULT '',
    `father_name`              VARCHAR(128) NOT NULL DEFAULT '',
    `birth_timestamp`          DATETIME     NOT NULL,
    `dna_confirmed`            TINYINT(1)   NOT NULL DEFAULT 0,
    `child_support_claimed`    TINYINT(1)   NOT NULL DEFAULT 0,
    `child_support_amount`     INT          NOT NULL DEFAULT 0,
    `child_support_claimed_at` DATETIME     NULL,
    `gender`                   VARCHAR(32)  NOT NULL DEFAULT 'unknown',
    `created_at`               DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_pregnancy_id` (`pregnancy_id`),
    UNIQUE KEY `uniq_child_id` (`child_id`),
    INDEX `idx_mother_citizenid` (`mother_citizenid`),
    INDEX `idx_father_citizenid` (`father_citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── STD ───────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_std` (
    `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid`           VARCHAR(64)  NOT NULL,
    `disease_id`    VARCHAR(32)  NOT NULL,
    `contracted_at` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `cured`         TINYINT(1)   NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_cid_disease`(`cid`,`disease_id`),
    INDEX `idx_cid_cured`(`cid`,`cured`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── CONTRACEPTION ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_contraception` (
    `id`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid`        VARCHAR(64)  NOT NULL,
    `expires_at` DATETIME     NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_cid`(`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── CONDOMS ───────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_condoms` (
    `id`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid`        VARCHAR(64)  NOT NULL,
    `expires_at` DATETIME     NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_cid`(`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── PRENATAL VITAMINS ─────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_vitamins` (
    `id`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid`        VARCHAR(64)  NOT NULL,
    `expires_at` DATETIME     NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_cid`(`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── PARTNERS ──────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_partners` (
    `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid_a`         VARCHAR(64)  NOT NULL,
    `cid_b`         VARCHAR(64)  NOT NULL,
    `registered_at` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_pair`(`cid_a`,`cid_b`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── DNA RESULTS ───────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_dna_results` (
    `id`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid`        VARCHAR(64)  NOT NULL,
    `target_cid` VARCHAR(64)  NOT NULL,
    `match_pct`  TINYINT      NOT NULL DEFAULT 0,
    `tested_at`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_cid`(`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── ULTRASOUND REPORTS ────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_ultrasounds` (
    `id`         INT UNSIGNED       NOT NULL AUTO_INCREMENT,
    `cid`        VARCHAR(64)        NOT NULL,
    `gender`     ENUM('boy','girl') NOT NULL,
    `birth_at`   DATETIME           NOT NULL,
    `scanned_at` DATETIME           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_cid`(`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── UPGRADING FROM v2.1.x? ────────────────────────────────────────────────────
-- The following tables from v2.1.1 are no longer used and can be safely dropped:
--   DROP TABLE IF EXISTS `grim_lm_coffee_posts`;
--   DROP TABLE IF EXISTS `grim_lm_coffee_likes`;
--   DROP TABLE IF EXISTS `grim_lm_coffee_comments`;
--   DROP TABLE IF EXISTS `grim_lm_bro_posts`;
--   DROP TABLE IF EXISTS `grim_lm_bro_likes`;
--   DROP TABLE IF EXISTS `grim_lm_bro_comments`;
--   DROP TABLE IF EXISTS `grim_lm_post_cooldowns`;
-- Uncomment and run manually when you're ready to clean those up.



-- ── COFFEE POSTS ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_coffee_posts` (
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid`         VARCHAR(64)  NOT NULL,
    `author_name` VARCHAR(128) NOT NULL,
    `body`        VARCHAR(400) NOT NULL,
    `media_url`   VARCHAR(512) NULL,
    `media_type`  ENUM('none','image','video') NOT NULL DEFAULT 'none',
    `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_created_at`(`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `grim_lm_coffee_comments` (
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `post_id`     INT UNSIGNED NOT NULL,
    `cid`         VARCHAR(64)  NOT NULL,
    `author_name` VARCHAR(128) NOT NULL,
    `body`        VARCHAR(250) NOT NULL,
    `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_post_id`(`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── BRO CODE POSTS ───────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `grim_lm_brocode_posts` (
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cid`         VARCHAR(64)  NOT NULL,
    `author_name` VARCHAR(128) NOT NULL,
    `body`        VARCHAR(400) NOT NULL,
    `media_url`   VARCHAR(512) NULL,
    `media_type`  ENUM('none','image','video') NOT NULL DEFAULT 'none',
    `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_created_at`(`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `grim_lm_brocode_comments` (
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `post_id`     INT UNSIGNED NOT NULL,
    `cid`         VARCHAR(64)  NOT NULL,
    `author_name` VARCHAR(128) NOT NULL,
    `body`        VARCHAR(250) NOT NULL,
    `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_post_id`(`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Optional: if your table already exists, add manually:
-- ALTER TABLE grim_lm_pregnancy ADD COLUMN preg_stage VARCHAR(32) NOT NULL DEFAULT 'early';


ALTER TABLE `grim_lm_pregnancy`
    ADD COLUMN IF NOT EXISTS `dna_confirmed` TINYINT(1) NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS `child_support_paid` TINYINT(1) NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS `child_support_amount` INT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS `child_support_paid_at` DATETIME NULL;
