CREATE TABLE IF NOT EXISTS `drug_selling_skills` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `levelpoints` varchar(50) DEFAULT NULL,
    `name` varchar(50) DEFAULT NULL,
    `user` varchar(50) DEFAULT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;