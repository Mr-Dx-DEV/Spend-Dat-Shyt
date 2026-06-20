CREATE TABLE IF NOT EXISTS `spoody_gunstores` (
  `storeid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `employees` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `stock` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`stock`)),
  `revenue` int(11) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `sales_history` longtext DEFAULT '[]',
  `points` longtext DEFAULT '[]',
  `munitions` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;