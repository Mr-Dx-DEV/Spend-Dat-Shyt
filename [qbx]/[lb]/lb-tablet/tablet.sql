CREATE TABLE IF NOT EXISTS `lbtablet_tablets` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier. we use id instead of identifier since some scripts automatically changes the max length of columns named identifier
    `tablet_name` VARCHAR(50) NOT NULL,
    `settings` LONGTEXT,

    `battery` TINYINT UNSIGNED NOT NULL DEFAULT 100,

    `is_setup` BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_apps_loggedin` (
    `tablet_id` VARCHAR(100) NOT NULL,
    `app` VARCHAR(25) NOT NULL,
    `account` VARCHAR(100) NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (`tablet_id`, `app`, `account`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_notifications` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `app` VARCHAR(50) NOT NULL,

    `title` VARCHAR(50) NOT NULL,
    `content` VARCHAR(500) NOT NULL,

    `thumbnail` VARCHAR(500) DEFAULT NULL,
    `avatar` VARCHAR(500) DEFAULT NULL,
    `show_avatar` BOOLEAN NOT NULL DEFAULT FALSE,
    `custom_data` TEXT DEFAULT NULL,

    `received_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Camera & photos app
CREATE TABLE IF NOT EXISTS `lbtablet_photo_albums` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `title` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES `lbtablet_tablets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_photos` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `link` VARCHAR(500),
    `is_video` BOOLEAN DEFAULT FALSE,
    `size` FLOAT NOT NULL DEFAULT 0,
    `metadata` VARCHAR(20) DEFAULT NULL,

    `is_favourite` BOOLEAN NOT NULL DEFAULT FALSE,

    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_photo_album_photos` (
    `album_id` INT UNSIGNED NOT NULL,
    `photo_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`album_id`, `photo_id`),
    FOREIGN KEY (`album_id`) REFERENCES `lbtablet_photo_albums`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`photo_id`) REFERENCES `lbtablet_photos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Notes app
CREATE TABLE IF NOT EXISTS `lbtablet_notes` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `title` VARCHAR(50) NOT NULL,
    `content` MEDIUMTEXT NOT NULL,

    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Mail app
CREATE TABLE IF NOT EXISTS `phone_mail_accounts` (
    `address` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`address`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_messages` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `recipient` VARCHAR(100) NOT NULL,
    `sender` VARCHAR(100) NOT NULL,

    `subject` VARCHAR(100) NOT NULL,
    `content` TEXT NOT NULL,
    `attachments` LONGTEXT, -- json array of attachments
    `actions` LONGTEXT, -- json array of actions

    `read` BOOLEAN NOT NULL DEFAULT FALSE,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_deleted` (
    `message_id` INT UNSIGNED NOT NULL,
    `address` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`message_id`, `address`),
    FOREIGN KEY (`message_id`) REFERENCES `phone_mail_messages`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts`(`address`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Clock
CREATE TABLE IF NOT EXISTS `lbtablet_clock_alarms` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `hours` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `minutes` TINYINT UNSIGNED NOT NULL DEFAULT 0,

    `label` VARCHAR(50),
    `enabled` BOOLEAN NOT NULL DEFAULT TRUE,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Voice memo
CREATE TABLE IF NOT EXISTS `lbtablet_voice_memo_recordings` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `file_name` VARCHAR(50) NOT NULL,
    `file_url` VARCHAR(500) NOT NULL,
    `file_length` INT(11) NOT NULL,

    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MDT
CREATE TABLE IF NOT EXISTS lbtablet_mdt_employees (
    id VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,

    display_name VARCHAR(100) DEFAULT NULL,
    avatar VARCHAR(500) DEFAULT NULL,
    callsign VARCHAR(100) DEFAULT NULL,

    PRIMARY KEY (id, department),
    INDEX idx_department (department),
    INDEX idx_display_name (display_name)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_profiles (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE, -- unique id, used for references (e.g. applied tags)

    profile_id VARCHAR(100) NOT NULL, -- vehicle plate, player identifier etc.
    department VARCHAR(50) NOT NULL,

    avatar VARCHAR(500) DEFAULT NULL,
    profile_type VARCHAR(50) NOT NULL DEFAULT 'player', -- player, vehicle, property, weapon

    PRIMARY KEY (profile_id, department, profile_type),
    INDEX idx_department (department),
    INDEX idx_profile_type (profile_type)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_profiles_fields (
    profile_id INT UNSIGNED NOT NULL,
    field_id VARCHAR(50) NOT NULL,
    field_value MEDIUMTEXT NOT NULL, -- dropdowns, descriptions

    PRIMARY KEY (profile_id, field_id),
    FOREIGN KEY (profile_id) REFERENCES lbtablet_mdt_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_profiles_photos (
    profile_id INT UNSIGNED NOT NULL,
    field_id VARCHAR(50) NOT NULL,
    attachment VARCHAR(500) NOT NULL,

    PRIMARY KEY (profile_id, field_id, attachment),
    FOREIGN KEY (profile_id) REFERENCES lbtablet_mdt_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_weapons (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE, -- unique id, used for references (e.g. applied tags)
    department VARCHAR(50) NOT NULL,

    serial_number VARCHAR(100) NOT NULL,
    weapon_name VARCHAR(100) DEFAULT NULL,
    owner_id VARCHAR(100) DEFAULT NULL,

    registered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (serial_number, department),
    INDEX idx_department_owner (department, owner_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_bulletin (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    title VARCHAR(100) NOT NULL,
    content MEDIUMTEXT NOT NULL,
    pinned BOOLEAN NOT NULL DEFAULT FALSE,

    created_by VARCHAR(100) DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_department (department),
    INDEX idx_pinned (pinned),
    INDEX idx_created_at (created_at),
    FOREIGN KEY (created_by, department) REFERENCES lbtablet_mdt_employees(id, department) ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_catalog_categories (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    title VARCHAR(100) NOT NULL,

    UNIQUE KEY (department, title),
    INDEX idx_department (department)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_catalog_items (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    category_id INT UNSIGNED NOT NULL,
    severity VARCHAR(100) DEFAULT NULL, -- misdemeanor, felony, etc.
    title VARCHAR(100) NOT NULL,
    content MEDIUMTEXT DEFAULT NULL,
    fine INT UNSIGNED DEFAULT NULL,
    jail INT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (category_id) REFERENCES lbtablet_mdt_catalog_categories(id) ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE KEY (department, category_id, title, severity),
    INDEX idx_department (department)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_reports (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    tab_id VARCHAR(50) NOT NULL,

    created_by VARCHAR(100) DEFAULT NULL,

    title VARCHAR(100) NOT NULL,

    is_private BOOLEAN NOT NULL DEFAULT FALSE,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_department (department),
    FOREIGN KEY (created_by, department) REFERENCES lbtablet_mdt_employees(id, department) ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_reports_fields (
    report_id INT UNSIGNED NOT NULL,
    field_id VARCHAR(50) NOT NULL,
    field_value MEDIUMTEXT NOT NULL, -- dropdowns, descriptions

    PRIMARY KEY (report_id, field_id),
    FOREIGN KEY (report_id) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_reports_photos (
    report_id INT UNSIGNED NOT NULL,
    field_id VARCHAR(50) NOT NULL,
    attachment VARCHAR(500) NOT NULL,

    PRIMARY KEY (report_id, field_id, attachment),
    FOREIGN KEY (report_id) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_reports_linked_reports (
    report_id INT UNSIGNED NOT NULL,
    linked_report_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (report_id, linked_report_id),
    FOREIGN KEY (report_id) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (linked_report_id) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_reports_involved (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,
    report_id INT UNSIGNED NOT NULL,
    involved VARCHAR(100) NOT NULL, -- the player identifier/weapon id/vehicle plate
    involvement VARCHAR(50) NOT NULL,
    profile_type VARCHAR(50) NOT NULL, -- player, vehicle, weapon, property

    fine INT UNSIGNED DEFAULT NULL,
    jail_time INT UNSIGNED DEFAULT NULL,

    fined BOOLEAN NOT NULL DEFAULT FALSE,
    jailed BOOLEAN NOT NULL DEFAULT FALSE,

    UNIQUE KEY (report_id, involved, involvement),
    INDEX idx_department (department),
    INDEX idx_involved (involved),
    FOREIGN KEY (report_id) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_reports_involved_charges (
    department VARCHAR(50) NOT NULL,
    involved_id INT UNSIGNED NOT NULL,

    report_id INT UNSIGNED NOT NULL,
    involved VARCHAR(100) NOT NULL, -- the player identifier/weapon id/vehicle plate
    involvement VARCHAR(50) NOT NULL,
    charge_id INT UNSIGNED NOT NULL,
    charges TINYINT UNSIGNED NOT NULL DEFAULT 1,

    PRIMARY KEY (report_id, involved, charge_id),
    INDEX idx_involved (involved),
    INDEX idx_department (department),
    FOREIGN KEY (involved_id) REFERENCES lbtablet_mdt_reports_involved(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (report_id) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (charge_id) REFERENCES lbtablet_mdt_catalog_items(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_reports_access (
    report_id INT UNSIGNED NOT NULL,
    employee_id VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,

    PRIMARY KEY (report_id, employee_id),
    FOREIGN KEY (report_id) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (employee_id, department) REFERENCES lbtablet_mdt_employees(id, department) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_jail (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    prisoner VARCHAR(100) NOT NULL,
    reason MEDIUMTEXT NOT NULL,
    original_time INT UNSIGNED NOT NULL,
    remaining_time INT UNSIGNED NOT NULL,
    linked_report INT UNSIGNED DEFAULT NULL,
    jailed_by VARCHAR(100) DEFAULT NULL,
    jailed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_department (department),
    INDEX idx_prisoner (prisoner),
    INDEX idx_reason (reason(100)),
    INDEX idx_remaining_time (remaining_time),
    FOREIGN KEY (linked_report) REFERENCES lbtablet_mdt_reports(id) ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_wiretaps (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    phone_number VARCHAR(15) NOT NULL,
    tapped_by VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_department (department),
    INDEX idx_created_at (created_at),
    FOREIGN KEY (tapped_by, department) REFERENCES lbtablet_mdt_employees(id, department) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_wiretap_subscribers (
    wiretap_id INT UNSIGNED NOT NULL,
    subscriber_id VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,

    PRIMARY KEY (wiretap_id, subscriber_id),
    FOREIGN KEY (wiretap_id) REFERENCES lbtablet_mdt_wiretaps(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_phone_unlocks (
    phone_number VARCHAR(15) NOT NULL,
    department VARCHAR(50) NOT NULL,

    attempts TINYINT UNSIGNED NOT NULL DEFAULT 0, -- the number of attempts used to unlock the phone
    unlocked BOOLEAN NOT NULL DEFAULT FALSE, -- whether the phone is unlocked or not
    finished_at DATETIME NOT NULL, -- the time when the unlocking process finished

    PRIMARY KEY (phone_number, department)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_tags (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    tag_name VARCHAR(50) NOT NULL,
    tag_color VARCHAR(10) NOT NULL,
    tag_type VARCHAR(50) NOT NULL,

    UNIQUE KEY (department, tag_name, tag_type),
    INDEX idx_department (department)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_applied_tags (
    tag_id INT UNSIGNED NOT NULL,

    applied_id INT UNSIGNED NOT NULL,
    applied_type VARCHAR(50) NOT NULL, -- employee, profile, etc.

    PRIMARY KEY (tag_id, applied_id, applied_type),
    FOREIGN KEY (tag_id) REFERENCES lbtablet_mdt_tags(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,

    created_by VARCHAR(100) DEFAULT NULL,
    related_id INT UNSIGNED DEFAULT NULL,
    log_action VARCHAR(50) NOT NULL,
    log_type VARCHAR(100) NOT NULL,
    tab_id VARCHAR(100) DEFAULT NULL,
    title VARCHAR(100) NOT NULL,
    content MEDIUMTEXT NOT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_department (department),
    INDEX idx_log_action (log_action),
    INDEX idx_log_type (log_type),
    INDEX idx_title (title),
    INDEX idx_content (content(100)),
    FOREIGN KEY (created_by, department) REFERENCES lbtablet_mdt_employees(id, department) ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_chat_rooms (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,
    label VARCHAR(50) NOT NULL,
    icon VARCHAR(500) DEFAULT NULL,
    is_private BOOLEAN NOT NULL DEFAULT FALSE,
    creator VARCHAR(100) NOT NULL,
    last_message_id INT UNSIGNED DEFAULT NULL,
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_department (department),
    INDEX idx_last_updated (last_updated)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_chat_rooms_messages (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    room_id INT UNSIGNED NOT NULL,
    author VARCHAR(100) NOT NULL,
    content TEXT DEFAULT NULL,
    attachments TEXT DEFAULT NULL,
    reply_to INT UNSIGNED DEFAULT NULL, -- the message id of the message being replied to

    sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (room_id) REFERENCES lbtablet_mdt_chat_rooms(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_chat_rooms_reactions (
    message_id INT UNSIGNED NOT NULL,
    reaction VARCHAR(50) NOT NULL,
    member VARCHAR(100) NOT NULL,

    PRIMARY KEY (message_id, reaction, member),
    FOREIGN KEY (message_id) REFERENCES lbtablet_mdt_chat_rooms_messages(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

ALTER TABLE lbtablet_mdt_chat_rooms ADD FOREIGN KEY (last_message_id) REFERENCES lbtablet_mdt_chat_rooms_messages(id) ON UPDATE CASCADE ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_chat_rooms_members (
    room_id INT UNSIGNED NOT NULL,
    member VARCHAR(100) NOT NULL,
    notifications INT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (room_id, member),
    FOREIGN KEY (room_id) REFERENCES lbtablet_mdt_chat_rooms(id) ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX idx_member_room (member, room_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS lbtablet_mdt_profiles_charges (
    profile_id INT UNSIGNED NOT NULL,
    charge_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (profile_id, charge_id),
    FOREIGN KEY (profile_id) REFERENCES lbtablet_mdt_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (charge_id) REFERENCES lbtablet_mdt_catalog_items(id) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
