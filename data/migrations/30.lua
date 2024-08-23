function onUpdateDatabase()
<<<<<<< HEAD
	print("> Updating database to version 30 (store system)")

	db.query("ALTER TABLE `accounts` ADD COLUMN `coins` int(11) NOT NULL DEFAULT '0'")

	db.query([[
		CREATE TABLE IF NOT EXISTS `store_history` (
			`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			`account_id` int(11) NOT NULL,
			`coins` int(10) NOT NULL DEFAULT '0',
			`description` varchar(256) NOT NULL DEFAULT '',
			`timestamp` bigint(20) unsigned NOT NULL,
			PRIMARY KEY (`id`),
			FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE
		) ENGINE=InnoDB;
	]])

	return true
end
=======
	print("> Updating database to version 30 (reward boss system)")
	db.query([[
		CREATE TABLE IF NOT EXISTS `player_rewarditems` (
		  `player_id` int NOT NULL,
		  `sid` int NOT NULL COMMENT 'range 0-100 will be reserved for adding items to player who are offline and all > 100 is for items saved from reward chest',
		  `pid` int NOT NULL DEFAULT '0',
		  `itemtype` smallint unsigned NOT NULL,
		  `count` smallint NOT NULL DEFAULT '0',
		  `attributes` blob NOT NULL,
		  UNIQUE KEY `player_id_2` (`player_id`, `sid`),
		  FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
		) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;
	]])
	return true
end
>>>>>>> 0da6263... Added Reward Container & Boss System (#14)
