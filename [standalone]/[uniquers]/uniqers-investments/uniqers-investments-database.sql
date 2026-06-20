
CREATE TABLE `uniqers_investments` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `playtime` int(11) DEFAULT NULL,
  `selectedinvest` varchar(100) NOT NULL,
  `investendtime` datetime NOT NULL,
  `claimed` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE `uniqers_investments_history` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `selectedinvest` varchar(100) NOT NULL,
  `claimed` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


ALTER TABLE `uniqers_investments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);


ALTER TABLE `uniqers_investments_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);
  

ALTER TABLE `uniqers_investments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;


ALTER TABLE `uniqers_investments_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
