use aot_tests;

CREATE TABLE `tb_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `document` varchar(14) NOT NULL,
  `birth_date` date NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `creation_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `last_delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);
