ALTER TABLE `users`
    ADD COLUMN `ssn` varchar(16) DEFAULT NULL,
    ADD COLUMN `cityhall_data` longtext DEFAULT NULL;

ALTER TABLE `owned_vehicles`
    ADD COLUMN `vin` varchar(17) DEFAULT NULL,
    ADD COLUMN `vin_hidden` int(3) DEFAULT 0,
    ADD COLUMN `owner_name` varchar(80) DEFAULT NULL,
    ADD COLUMN `owner_history` longtext DEFAULT NULL,
    ADD COLUMN `insurance` longtext DEFAULT NULL;

CREATE TABLE IF NOT EXISTS `fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `issuer` varchar(100) DEFAULT NULL,
  `issuer_job` varchar(50) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `issue_date` int(11) DEFAULT NULL,
  `date_to_pay` int(11) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `is_paid` int(11) DEFAULT 0,
  `paid_date` int(11) DEFAULT NULL,
  `canceled` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `taxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` varchar(50) DEFAULT NULL,
  `receiver_name` varchar(150) DEFAULT NULL,
  `received_date` int(11) DEFAULT NULL,
  `title` varchar(450) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT 0,
  `paid_date` int(11) DEFAULT NULL,
  `canceled` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `taxes_business` (
  `job` varchar(60) NOT NULL,
  `job_label` varchar(50) DEFAULT NULL,
  `period` varchar(7) DEFAULT NULL,
  `amount` int(16) NOT NULL DEFAULT 0,
  `paid_amount` int(16) NOT NULL DEFAULT 0,
  `delayed_amount` int(16) DEFAULT 0,
  `late_fee_applied` int(5) DEFAULT 0,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `paid_date` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `resumes` (
  `job` varchar(50) NOT NULL,
  `allowed` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `resumes_data` (
  `sender` varchar(100) NOT NULL,
  `sender_name` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `date` bigint(20) NOT NULL DEFAULT 0,
  `informations` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `vms_business` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT '',
  `owner` mediumtext DEFAULT NULL,
  `employees` longtext DEFAULT '{}',
  `stock` longtext DEFAULT '{}',
  `data` longtext DEFAULT '{}',
  `announcements` longtext DEFAULT '{}',
  `orders` longtext DEFAULT '{}',
  `history` longtext DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;