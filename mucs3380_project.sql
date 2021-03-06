-- Edited by Jakob D 5/03/2016



-- student TABLE
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
    `id` INTEGER NOT NULL,
    `username` VARCHAR(16) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `name_first` VARCHAR(30) DEFAULT NULL,
    `name_last` VARCHAR(45) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = INNODB;


-- 
-- employee_permissions TABLE
-- 
DROP TABLE IF EXISTS `employee_permissions`;
CREATE TABLE `employee_permissions` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = INNODB;

-- 
-- employee TABLE
-- 
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
    `id` INTEGER NOT NULL,
    `username` VARCHAR(16) NOT NULL,
    `user_type` INTEGER NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `salt` VARCHAR(20) NOT NULL,
    `hashed_password` VARCHAR(256) NOT NULL,
    `name_first` VARCHAR(30) DEFAULT NULL,
    `name_last` VARCHAR(45) NOT NULL,
    FOREIGN KEY (`user_type`) REFERENCES `employee_permissions`(`id`) ON DELETE CASCADE,
    PRIMARY KEY(`id`)
) ENGINE = INNODB;

-- 
-- location TABLE
-- 
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) DEFAULT NULL,
    `terminal_id` INTEGER NOT NULL,
    PRIMARY KEY(`id`, `terminal_id`)
) ENGINE = INNODB;

-- 
-- waiver TABLE
-- 
DROP TABLE IF EXISTS `waiver`;
CREATE TABLE `waiver` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = INNODB;

-- 
-- expired_waiver TABLE
-- 
DROP TABLE IF EXISTS `expired_waiver`;
CREATE TABLE `expired_waiver` (
    `student_id` INTEGER NOT NULL,
    `waiver_id` INTEGER NOT NULL,
    `initialized` DATETIME NOT NULL,
    `expires` DATETIME NOT NULL,
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`waiver_id`) REFERENCES `waiver`(`id`) ON DELETE CASCADE,
    PRIMARY KEY(`student_id`, `waiver_id`)
) ENGINE = INNODB;

-- 
-- item_condition TABLE
-- 
DROP TABLE IF EXISTS `item_condition`;
CREATE TABLE `item_condition` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = INNODB;

-- 
-- item TABLE
-- 
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    `available` TINYINT(1) NOT NULL,
    `item_condition_id` INTEGER NOT NULL,
    `location_id` INTEGER NOT NULL,
    FOREIGN KEY (`item_condition_id`) REFERENCES `item_condition`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`location_id`) REFERENCES `location`(`id`) ON DELETE CASCADE,
    PRIMARY KEY(`id`)
) ENGINE = INNODB;



-- 
-- item_category TABLE
-- 
DROP TABLE IF EXISTS `item_category`;
CREATE TABLE `item_category` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    `waiver` INT,
    `item_id` INTEGER NOT NULL,
    FOREIGN KEY (`item_id`) REFERENCES `item`(`id`) ON DELETE CASCADE,
    PRIMARY KEY(`id`)
) ENGINE = INNODB;

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
    FOREIGN KEY (`item_id`) REFERENCES `item`(`id`) ON DELETE CASCADE,
    PRIMARY KEY(`date_time`, `item_id`)
) ENGINE = INNODB;

-- 
-- student_item_transaction TABLE
-- 
DROP TABLE IF EXISTS `student_item_transaction`;
CREATE TABLE `student_item_transaction` (
	`transaction_id` INTEGER NOT NULL AUTO_INCREMENT,
    `student_id` INTEGER NOT NULL,
    `item_id` INTEGER NOT NULL,
    `employee_id` INTEGER NOT NULL,
    `location_id` INTEGER NOT NULL,
    `item_condition_id` INTEGER NOT NULL,
    `transaction_type` VARCHAR(50) DEFAULT NULL, -- Made it hold STRINGS rather than INTEGERS and making another table
    `transaction_datetime` DATETIME, 
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`item_id`) REFERENCES `item`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`employee_id`) REFERENCES `employee`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`location_id`) REFERENCES `location`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`item_condition_id`) REFERENCES `item_condition`(`id`) ON DELETE CASCADE,
    PRIMARY KEY(`transaction_id`)
) ENGINE = INNODB;

-- INSERT INTO employee (id,username,user_type,email,salt,hashed_password,name_first,name_last) VALUES (123456 , 'adminUser', '1', 'testemail@mail.missouri.edu', '1419814819', '$2y$10$3FleH8rp.AcSuPg4BDAm7epLg3sw6yZ1XcS0VIMmDRQXTSV/4wWwK', 'Adam', 'U');
-- INSERT INTO employee (id,username,user_type,email,salt,hashed_password,name_first,name_last) VALUES (654321 , 'regularUser', '0', 'test@mail.missouri.edu', '2106281797', '$2y$10$18yilYZNmpONY9DKG0ZIh.sqNkRSfW.6Y/siAfVofEfX.cII9qRxu', 'Dude', 'U');

--
--The MIT License (MIT)
--Copyright (c) 2016 Hunter Ginther, Jakob Daugherty, Zach Dolan, Kevin Free, Michael McLaughlin, and Alyssa Nielsen 
--
--Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--
--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.