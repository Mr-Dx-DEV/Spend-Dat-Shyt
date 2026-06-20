CREATE TABLE IF NOT EXISTS `bank_accounts_new` (
  `id` varchar(50) NOT NULL,
  `amount` int(11) DEFAULT 0,
  `transactions` longtext DEFAULT '[]',
  `auth` longtext DEFAULT '[]',
  `isFrozen` int(11) DEFAULT 0,
  `creator` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `player_transactions` (
  `id` varchar(50) NOT NULL,
  `isFrozen` int(11) DEFAULT 0,
  `transactions` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `player_credit_scores` (
  `id` varchar(50) NOT NULL,
  `score` int(11) NOT NULL DEFAULT 650,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `player_loans` (
  `loan_id` varchar(64) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL,
  `total_owed` int(11) NOT NULL,
  `remaining` int(11) NOT NULL,
  `interest_rate` int(11) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` int(11) NOT NULL,
  `due_at` int(11) DEFAULT NULL,
  `paid_at` int(11) DEFAULT NULL,
  `max_eligibility_amount` int(11) NOT NULL DEFAULT 0,
  `overdue_days` int(11) NOT NULL DEFAULT 0,
  `credit_lost` int(11) NOT NULL DEFAULT 0,
  `last_penalty_at` int(11) DEFAULT NULL,
  `payments` longtext DEFAULT '[]',
  PRIMARY KEY (`loan_id`),
  KEY `citizenid_status` (`citizenid`, `status`)
);
