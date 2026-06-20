CREATE TABLE `sdcb_vehicles` (
  `id` VARCHAR(60) NOT NULL,
  `owner` VARCHAR(140) NOT NULL,
  `model_data` LONGTEXT NOT NULL,
  `vehicle_data` LONGTEXT NOT NULL,
  `location_data` LONGTEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `sdcb_vehicles`
  ADD PRIMARY KEY (`id`)
;

