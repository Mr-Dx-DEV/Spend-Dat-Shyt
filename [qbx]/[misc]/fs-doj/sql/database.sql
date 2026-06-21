-- ================================================================
-- fs-doj Complete Database Schema
-- Run this file to set up all required tables
-- ================================================================

-- ================================================================
-- CORE TABLES
-- ================================================================

-- Cases Table
CREATE TABLE IF NOT EXISTS `doj_cases` (
    `case_id` INT AUTO_INCREMENT PRIMARY KEY,
    `case_number` VARCHAR(50) UNIQUE NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `case_type` ENUM('criminal', 'civil', 'traffic', 'administrative') DEFAULT 'criminal',
    `status` ENUM('open', 'under_investigation', 'pending_trial', 'closed', 'dismissed') DEFAULT 'open',
    `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    `assigned_detective` VARCHAR(60),
    `assigned_prosecutor` VARCHAR(60),
    `defendant_identifier` VARCHAR(60),
    `defendant_name` VARCHAR(255),
    `created_by` VARCHAR(60) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `closed_at` TIMESTAMP NULL,
    `closure_reason` TEXT,
    INDEX `idx_status` (`status`),
    INDEX `idx_detective` (`assigned_detective`),
    INDEX `idx_defendant` (`defendant_identifier`),
    INDEX `idx_created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Reports Table
CREATE TABLE IF NOT EXISTS `doj_reports` (
    `report_id` INT AUTO_INCREMENT PRIMARY KEY,
    `report_number` VARCHAR(50) UNIQUE NOT NULL,
    `case_id` INT NULL,
    `report_type` VARCHAR(50) DEFAULT 'incident',
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `narrative` TEXT NULL,
    `location` VARCHAR(255),
    `incident_date` TIMESTAMP NULL,
    `officer_identifier` VARCHAR(60) NULL,
    `author_identifier` VARCHAR(60) NOT NULL,
    `author_name` VARCHAR(255),
    `officer_name` VARCHAR(255) NULL,
    `attachments` JSON,
    `involved_parties` JSON,
    `status` ENUM('draft', 'submitted', 'under_review', 'approved', 'rejected') DEFAULT 'draft',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`case_id`) REFERENCES `doj_cases`(`case_id`) ON DELETE SET NULL,
    INDEX `idx_case` (`case_id`),
    INDEX `idx_author` (`author_identifier`),
    INDEX `idx_officer` (`officer_identifier`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Citizens Database
CREATE TABLE IF NOT EXISTS `doj_citizens` (
    `citizen_id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(60) UNIQUE NOT NULL,
    `firstname` VARCHAR(100) NOT NULL,
    `lastname` VARCHAR(100) NOT NULL,
    `dateofbirth` VARCHAR(20) DEFAULT NULL,
    `sex` VARCHAR(10),
    `phone_number` VARCHAR(20),
    `address` VARCHAR(255),
    `height` INT(11) DEFAULT NULL,
    `notes` TEXT,
    `flags` JSON,
    `wanted` BOOLEAN DEFAULT FALSE,
    `warrant_active` BOOLEAN DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_identifier` (`identifier`),
    INDEX `idx_name` (`firstname`, `lastname`),
    INDEX `idx_wanted` (`wanted`),
    INDEX `idx_warrant` (`warrant_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Vehicles Database
CREATE TABLE IF NOT EXISTS `doj_vehicles` (
    `vehicle_id` INT AUTO_INCREMENT PRIMARY KEY,
    `plate` VARCHAR(20) UNIQUE NOT NULL,
    `model` VARCHAR(50),
    `owner_identifier` VARCHAR(60),
    `owner_name` VARCHAR(255),
    `registration_date` DATE,
    `color` VARCHAR(50),
    `vin` VARCHAR(50),
    `status` ENUM('registered', 'stolen', 'impounded', 'seized', 'destroyed') DEFAULT 'registered',
    `linked_case_id` INT NULL,
    `notes` TEXT,
    `flags` JSON,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`linked_case_id`) REFERENCES `doj_cases`(`case_id`) ON DELETE SET NULL,
    INDEX `idx_plate` (`plate`),
    INDEX `idx_owner` (`owner_identifier`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Court Hearings Table
CREATE TABLE IF NOT EXISTS `doj_court` (
    `hearing_id` INT AUTO_INCREMENT PRIMARY KEY,
    `case_id` INT NOT NULL,
    `hearing_type` VARCHAR(50) DEFAULT 'trial',
    `judge_identifier` VARCHAR(60),
    `judge_name` VARCHAR(255),
    `prosecutor_identifier` VARCHAR(60),
    `prosecutor_name` VARCHAR(255),
    `defendant_identifier` VARCHAR(60),
    `defendant_name` VARCHAR(255),
    `defense_attorney` VARCHAR(255),
    `courtroom` VARCHAR(50),
    `scheduled_for` TIMESTAMP NOT NULL,
    `duration_minutes` INT DEFAULT 60,
    `status` ENUM('scheduled', 'in_progress', 'completed', 'postponed', 'cancelled') DEFAULT 'scheduled',
    `outcome` TEXT,
    `verdict` ENUM('guilty', 'not_guilty', 'dismissed', 'settled', 'pending') DEFAULT 'pending',
    `sentence` TEXT,
    `fine_amount` DECIMAL(10,2) DEFAULT 0.00,
    `recording_ref` VARCHAR(255),
    `created_by` VARCHAR(60),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `completed_at` TIMESTAMP NULL,
    FOREIGN KEY (`case_id`) REFERENCES `doj_cases`(`case_id`) ON DELETE CASCADE,
    INDEX `idx_case` (`case_id`),
    INDEX `idx_judge` (`judge_identifier`),
    INDEX `idx_defendant` (`defendant_identifier`),
    INDEX `idx_scheduled` (`scheduled_for`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Announcements Table
CREATE TABLE IF NOT EXISTS `doj_announcements` (
    `announcement_id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    `author_identifier` VARCHAR(60),
    `author_name` VARCHAR(255),
    `target_audience` JSON,
    `expires_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_priority` (`priority`),
    INDEX `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Finances/Transactions Table
CREATE TABLE IF NOT EXISTS `doj_finances` (
    `transaction_id` INT AUTO_INCREMENT PRIMARY KEY,
    `transaction_type` ENUM('deposit', 'withdrawal', 'fine', 'payment', 'salary', 'purchase', 'seizure') NOT NULL,
    `amount` DECIMAL(10,2) NOT NULL,
    `description` VARCHAR(255),
    `source` VARCHAR(100),
    `destination` VARCHAR(100),
    `performed_by` VARCHAR(60),
    `performed_by_name` VARCHAR(255),
    `related_case_id` INT NULL,
    `meta` JSON,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`related_case_id`) REFERENCES `doj_cases`(`case_id`) ON DELETE SET NULL,
    INDEX `idx_type` (`transaction_type`),
    INDEX `idx_performed` (`performed_by`),
    INDEX `idx_date` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- DOJ Account Balance Table
CREATE TABLE IF NOT EXISTS `doj_account` (
    `account_id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_name` VARCHAR(50) NOT NULL UNIQUE DEFAULT 'doj_main',
    `balance` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_account_name` (`account_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default DOJ account
INSERT IGNORE INTO `doj_account` (`account_name`, `balance`) VALUES ('doj_main', 0.00);

-- Inspections Table
CREATE TABLE IF NOT EXISTS `doj_inspections` (
    `inspection_id` INT AUTO_INCREMENT PRIMARY KEY,
    `inspection_type` ENUM('traffic_stop', 'search', 'frisk', 'vehicle_inspection', 'property_inspection') NOT NULL,
    `subject_identifier` VARCHAR(60),
    `subject_name` VARCHAR(255),
    `vehicle_plate` VARCHAR(20),
    `location` VARCHAR(255),
    `officer_identifier` VARCHAR(60) NOT NULL,
    `officer_name` VARCHAR(255),
    `reason` TEXT,
    `findings` TEXT,
    `items_confiscated` JSON,
    `violations` JSON,
    `citations_issued` JSON,
    `arrest_made` BOOLEAN DEFAULT FALSE,
    `related_report_id` INT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`related_report_id`) REFERENCES `doj_reports`(`report_id`) ON DELETE SET NULL,
    INDEX `idx_subject` (`subject_identifier`),
    INDEX `idx_officer` (`officer_identifier`),
    INDEX `idx_type` (`inspection_type`),
    INDEX `idx_date` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Companies/Organizations Database
CREATE TABLE IF NOT EXISTS `doj_companies` (
    `company_id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_name` VARCHAR(255) UNIQUE NOT NULL,
    `company_type` VARCHAR(100),
    `industry` VARCHAR(100),
    `registration_number` VARCHAR(50) UNIQUE,
    `owner_identifier` VARCHAR(60),
    `owner_name` VARCHAR(255),
    `address` VARCHAR(255),
    `tax_id` VARCHAR(50),
    `registration_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `registered_by` VARCHAR(60),
    `incorporation_date` DATE NULL,
    `last_audit_date` DATE NULL,
    `phone` VARCHAR(20),
    `email` VARCHAR(255),
    `website` VARCHAR(255),
    `employees_count` INT DEFAULT 0,
    `employee_count` INT DEFAULT 0,
    `annual_revenue` DECIMAL(15,2) DEFAULT 0.00,
    `status` ENUM('active', 'suspended', 'under_investigation', 'closed', 'dissolved', 'pending_review', 'bankrupt') DEFAULT 'active',
    `linked_case_id` INT NULL,
    `assets_frozen` BOOLEAN DEFAULT FALSE,
    `notes` TEXT,
    `flags` JSON,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`linked_case_id`) REFERENCES `doj_cases`(`case_id`) ON DELETE SET NULL,
    INDEX `idx_name` (`company_name`),
    INDEX `idx_owner` (`owner_identifier`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Company Employees Junction Table
CREATE TABLE IF NOT EXISTS `doj_company_employees` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_id` INT NOT NULL,
    `employee_identifier` VARCHAR(60) NOT NULL,
    `employee_name` VARCHAR(255) NOT NULL,
    `position` VARCHAR(100),
    `department` VARCHAR(100),
    `salary` DECIMAL(10,2) DEFAULT 0.00,
    `hire_date` DATE,
    `employment_status` ENUM('active', 'on_leave', 'terminated', 'resigned') DEFAULT 'active',
    `permissions` JSON,
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`company_id`) REFERENCES `doj_companies`(`company_id`) ON DELETE CASCADE,
    INDEX `idx_company` (`company_id`),
    INDEX `idx_employee` (`employee_identifier`),
    INDEX `idx_status` (`employment_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Company Transactions Table
CREATE TABLE IF NOT EXISTS `doj_company_transactions` (
    `transaction_id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_id` INT NOT NULL,
    `transaction_type` ENUM('revenue', 'expense', 'investment', 'loan', 'tax_payment', 'fine', 'asset_purchase', 'asset_sale') NOT NULL,
    `amount` DECIMAL(15,2) NOT NULL,
    `description` TEXT,
    `category` VARCHAR(100),
    `performed_by` VARCHAR(60),
    `performed_by_name` VARCHAR(255),
    `receipt_number` VARCHAR(100),
    `tax_deductible` BOOLEAN DEFAULT FALSE,
    `fiscal_year` INT,
    `fiscal_quarter` INT,
    `meta` JSON,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`company_id`) REFERENCES `doj_companies`(`company_id`) ON DELETE CASCADE,
    INDEX `idx_company` (`company_id`),
    INDEX `idx_type` (`transaction_type`),
    INDEX `idx_date` (`created_at`),
    INDEX `idx_fiscal` (`fiscal_year`, `fiscal_quarter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Company Licenses/Permits Table
CREATE TABLE IF NOT EXISTS `doj_company_licenses` (
    `license_id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_id` INT NOT NULL,
    `license_type` VARCHAR(100) NOT NULL,
    `license_number` VARCHAR(100) UNIQUE,
    `issued_date` DATE NOT NULL,
    `expiry_date` DATE,
    `status` ENUM('active', 'expired', 'suspended', 'revoked', 'pending_renewal') DEFAULT 'active',
    `issued_by` VARCHAR(60),
    `issued_by_name` VARCHAR(255),
    `annual_fee` DECIMAL(10,2) DEFAULT 0.00,
    `conditions` TEXT,
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`company_id`) REFERENCES `doj_companies`(`company_id`) ON DELETE CASCADE,
    INDEX `idx_company` (`company_id`),
    INDEX `idx_status` (`status`),
    INDEX `idx_type` (`license_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Company Assets Table
CREATE TABLE IF NOT EXISTS `doj_company_assets` (
    `asset_id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_id` INT NOT NULL,
    `asset_type` ENUM('vehicle', 'property', 'equipment', 'inventory', 'intellectual_property', 'other') NOT NULL,
    `asset_name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `purchase_price` DECIMAL(15,2),
    `current_value` DECIMAL(15,2),
    `purchase_date` DATE,
    `serial_number` VARCHAR(100),
    `location` VARCHAR(255),
    `status` ENUM('owned', 'leased', 'financed', 'sold', 'seized', 'destroyed') DEFAULT 'owned',
    `depreciation_rate` DECIMAL(5,2),
    `notes` TEXT,
    `meta` JSON,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`company_id`) REFERENCES `doj_companies`(`company_id`) ON DELETE CASCADE,
    INDEX `idx_company` (`company_id`),
    INDEX `idx_type` (`asset_type`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Company Contacts Table
CREATE TABLE IF NOT EXISTS `doj_company_contacts` (
    `contact_id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_id` INT NOT NULL,
    `contact_type` ENUM('primary', 'billing', 'legal', 'emergency', 'other') NOT NULL,
    `contact_name` VARCHAR(255) NOT NULL,
    `position` VARCHAR(100),
    `phone` VARCHAR(20),
    `email` VARCHAR(255),
    `address` VARCHAR(255),
    `notes` TEXT,
    `is_primary` BOOLEAN DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`company_id`) REFERENCES `doj_companies`(`company_id`) ON DELETE CASCADE,
    INDEX `idx_company` (`company_id`),
    INDEX `idx_type` (`contact_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Warrants Table
CREATE TABLE IF NOT EXISTS `doj_warrants` (
    `warrant_id` INT AUTO_INCREMENT PRIMARY KEY,
    `warrant_number` VARCHAR(50) UNIQUE NOT NULL,
    `warrant_type` ENUM('arrest', 'search', 'bench', 'seizure') NOT NULL,
    `subject_identifier` VARCHAR(60),
    `subject_name` VARCHAR(255) NOT NULL,
    `case_id` INT NULL,
    `issued_by` VARCHAR(60) NOT NULL,
    `issued_by_name` VARCHAR(255),
    `judge_identifier` VARCHAR(60),
    `judge_name` VARCHAR(255),
    `reason` TEXT NOT NULL,
    `location` VARCHAR(255),
    `status` ENUM('active', 'executed', 'expired', 'recalled') DEFAULT 'active',
    `issued_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `expiry_date` TIMESTAMP NULL,
    `executed_date` TIMESTAMP NULL,
    `executed_by` VARCHAR(60),
    `notes` TEXT,
    FOREIGN KEY (`case_id`) REFERENCES `doj_cases`(`case_id`) ON DELETE SET NULL,
    INDEX `idx_subject` (`subject_identifier`),
    INDEX `idx_type` (`warrant_type`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Licenses Table
CREATE TABLE IF NOT EXISTS `doj_licenses` (
    `license_id` INT AUTO_INCREMENT PRIMARY KEY,
    `citizen_id` INT NOT NULL,
    `license_type` VARCHAR(50) NOT NULL,
    `status` ENUM('active', 'suspended', 'revoked', 'expired') DEFAULT 'active',
    `issued_date` DATE NOT NULL,
    `expiry_date` DATE NULL,
    `issued_by_identifier` VARCHAR(60),
    `issued_by_name` VARCHAR(255),
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`citizen_id`) REFERENCES `doj_citizens`(`citizen_id`) ON DELETE CASCADE,
    INDEX `idx_citizen` (`citizen_id`),
    INDEX `idx_type` (`license_type`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Audit Log Table
CREATE TABLE IF NOT EXISTS `doj_audit_log` (
    `log_id` INT AUTO_INCREMENT PRIMARY KEY,
    `action` VARCHAR(100) NOT NULL,
    `category` VARCHAR(50),
    `performed_by` VARCHAR(60) NOT NULL,
    `performed_by_name` VARCHAR(255),
    `target_identifier` VARCHAR(60),
    `target_name` VARCHAR(255),
    `details` TEXT,
    `meta` JSON,
    `ip_address` VARCHAR(45),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_action` (`action`),
    INDEX `idx_performer` (`performed_by`),
    INDEX `idx_date` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================================
-- VIEWS (Backward Compatibility)
-- ================================================================

-- Court Hearings View for backward compatibility
DROP VIEW IF EXISTS `doj_court_hearings`;
CREATE VIEW `doj_court_hearings` AS
SELECT
    hearing_id,
    case_id,
    hearing_type,
    judge_identifier,
    judge_name,
    prosecutor_identifier,
    prosecutor_name,
    defendant_identifier,
    defendant_name,
    defense_attorney,
    courtroom,
    scheduled_for,
    duration_minutes,
    status,
    outcome,
    verdict,
    sentence,
    fine_amount,
    recording_ref,
    created_by,
    created_at,
    updated_at,
    completed_at
FROM `doj_court`;
