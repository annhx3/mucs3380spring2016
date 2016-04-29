-- Edited by Hunter G. 4/28/2016

-- student TABLE
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
    `id` INTEGER NOT NULL,
    `username` VARCHAR(16) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `name_first` VARCHAR(30) DEFAULT NULL,
    `name_last` VARCHAR(45) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;

-- 
-- employee TABLE
-- 
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
    `id` INTEGER NOT NULL,
    `username` VARCHAR(16) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `salt` VARCHAR(20) NOT NULL,
    `hashed_password` VARCHAR(256) NOT NULL,
    `name_first` VARCHAR(30) DEFAULT NULL,
    `name_last` VARCHAR(45) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;

-- 
-- employee_permissions TABLE
-- 
DROP TABLE IF EXISTS `employee_permissions`;
CREATE TABLE `employee_permissions` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;

-- 
-- location TABLE
-- 
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) DEFAULT NULL,
    `terminal_id` INTEGER NOT NULL,
    PRIMARY KEY(`id`, `terminal_id`)
) ENGINE = InnoDB;

-- 
-- waiver TABLE
-- 
DROP TABLE IF EXISTS `waiver`;
CREATE TABLE `waiver` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;

-- 
-- expired_waiver TABLE
-- 
DROP TABLE IF EXISTS `expired_waiver`;
CREATE TABLE `expired_waiver` (
    `student_id` INTEGER NOT NULL,
    `waiver_id` INTEGER NOT NULL,
    `initialized` DATETIME NOT NULL,
    `expires` DATETIME NOT NULL,
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`),
    FOREIGN KEY (`waiver_id`) REFERENCES `waiver`(`id`),
    PRIMARY KEY(`student_id`, `waiver_id`)
) ENGINE = InnoDB;

-- 
-- item TABLE
-- 
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    `available` TINYINT(1) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;

-- 
-- item_condition TABLE
-- 
DROP TABLE IF EXISTS `item_condition`;
CREATE TABLE `item_condition` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;

-- 
-- item_category TABLE
-- 
DROP TABLE IF EXISTS `item_category`;
CREATE TABLE `item_category` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    `waiver` INT,
    `item_id` INTEGER NOT NULL,
    FOREIGN KEY (`item_id`) REFERENCES `item`(`id`),
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;

-- 
-- item_condition_update TABLE
-- 
DROP TABLE IF EXISTS `item_condition_update`;
CREATE TABLE `item_condition_update` (
    `item_condition_id_old` INTEGER NOT NULL,
    `item_id` INTEGER NOT NULL,
    `item_condition_id_new` INTEGER NOT NULL,
    `date_time` DATETIME NOT NULL,
    `employee_id` INTEGER NOT NULL,
    `item_condition_updatecol` VARCHAR(45) DEFAULT NULL,
    FOREIGN KEY (`item_id`) REFERENCES `item`(`id`),
    PRIMARY KEY(`date_time`, `item_id`)
) ENGINE = InnoDB;

-- 
-- student_item_transaction TABLE
-- 
DROP TABLE IF EXISTS `student_item_transaction`;
CREATE TABLE `student_item_transaction` (
    `student_id` INTEGER NOT NULL,
    `item_id` INTEGER NOT NULL,
    `employee_id` INTEGER NOT NULL,
    `location_id` INTEGER NOT NULL,
    `item_condition_id` INTEGER NOT NULL,
    `transaction_type` VARCHAR(50) DEFAULT NULL, -- Made it hold STRINGS rather than INTEGERS and making another table
    `transaction_datetime` DATETIME,
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`),
    FOREIGN KEY (`item_id`) REFERENCES `item`(`id`),
    FOREIGN KEY (`employee_id`) REFERENCES `employee`(`id`),
    FOREIGN KEY (`location_id`) REFERENCES `location`(`id`),
    FOREIGN KEY (`item_condition_id`) REFERENCES `item_condition`(`id`),
    PRIMARY KEY(`student_id`, `item_id`, `employee_id`)
) ENGINE = InnoDB;