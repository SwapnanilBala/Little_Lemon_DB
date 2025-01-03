-- MySQL Script generated by MySQL Workbench
-- Thu Dec 26 14:09:06 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `little_lemon_db` ;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`tables_`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`tables_` (
  `table_number` INT NOT NULL,
  `availability` VARCHAR(15) NULL DEFAULT NULL,
  `booking_no` INT NULL DEFAULT NULL,
  `booking_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`table_number`),
  INDEX `fk_booking_no` (`booking_no` ASC) VISIBLE,
  INDEX `fk_booking_time` (`booking_time` ASC) VISIBLE,
  CONSTRAINT `fk_booking_no`
    FOREIGN KEY (`booking_no`)
    REFERENCES `little_lemon_db`.`bookings` (`booking_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_time`
    FOREIGN KEY (`booking_time`)
    REFERENCES `little_lemon_db`.`bookings` (`booking_slot`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `booking_slot` DATETIME NULL DEFAULT NULL,
  `name` VARCHAR(65) NOT NULL,
  `phone_no` VARCHAR(20) NOT NULL,
  `email` VARCHAR(35) NULL DEFAULT NULL,
  `table_no` INT NULL DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE INDEX `booking_slot` (`booking_slot` ASC) VISIBLE,
  INDEX `table_no` (`table_no` ASC) VISIBLE,
  CONSTRAINT `bookings_ibfk_1`
    FOREIGN KEY (`table_no`)
    REFERENCES `little_lemon_db`.`tables_` (`table_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `booking_no` INT NULL DEFAULT NULL,
  `customer_name` VARCHAR(65) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(35) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `booking_no` (`booking_no` ASC) VISIBLE,
  CONSTRAINT `customers_ibfk_1`
    FOREIGN KEY (`booking_no`)
    REFERENCES `little_lemon_db`.`bookings` (`booking_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`menus` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `cuisine` VARCHAR(25) NULL DEFAULT NULL,
  `food_type` VARCHAR(25) NULL DEFAULT NULL,
  `price` FLOAT NULL DEFAULT NULL,
  `chefs_comment` VARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`offline_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`offline_customers` (
  `offline_customers_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(35) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(35) NULL DEFAULT NULL,
  PRIMARY KEY (`offline_customers_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`offline_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`offline_orders` (
  `offline_orders_id` INT NOT NULL AUTO_INCREMENT,
  `offline_customers_id` INT NOT NULL,
  `menu_no` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`offline_orders_id`),
  INDEX `offline_customers_id` (`offline_customers_id` ASC) VISIBLE,
  INDEX `menu_no` (`menu_no` ASC) VISIBLE,
  CONSTRAINT `offline_orders_ibfk_1`
    FOREIGN KEY (`offline_customers_id`)
    REFERENCES `little_lemon_db`.`offline_customers` (`offline_customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `offline_orders_ibfk_2`
    FOREIGN KEY (`menu_no`)
    REFERENCES `little_lemon_db`.`menus` (`menu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`offline_payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`offline_payments` (
  `offline_payments_id` INT NOT NULL AUTO_INCREMENT,
  `offline_orders_no` INT NOT NULL,
  `payment_type` VARCHAR(15) NULL DEFAULT NULL,
  `remarks` VARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (`offline_payments_id`),
  INDEX `offline_orders_no` (`offline_orders_no` ASC) VISIBLE,
  CONSTRAINT `offline_payments_ibfk_1`
    FOREIGN KEY (`offline_orders_no`)
    REFERENCES `little_lemon_db`.`offline_orders` (`offline_orders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `menu_no` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `menu_no` (`menu_no` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `little_lemon_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`menu_no`)
    REFERENCES `little_lemon_db`.`menus` (`menu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `order_no` INT NOT NULL,
  `table_no` INT NOT NULL,
  `final_bill` FLOAT NULL DEFAULT NULL,
  `payment_type` VARCHAR(15) NULL DEFAULT NULL,
  `remarks` VARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `order_no` (`order_no` ASC) VISIBLE,
  INDEX `fk_table_no` (`table_no` ASC) VISIBLE,
  CONSTRAINT `fk_table_no`
    FOREIGN KEY (`table_no`)
    REFERENCES `little_lemon_db`.`tables_` (`table_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `payments_ibfk_1`
    FOREIGN KEY (`order_no`)
    REFERENCES `little_lemon_db`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`staffs` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(25) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(65) NULL DEFAULT NULL,
  `ph_no` VARCHAR(33) NULL DEFAULT NULL,
  `address` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `little_lemon_db` ;

-- -----------------------------------------------------
-- Placeholder table for view `little_lemon_db`.`important_details_online`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`important_details_online` (`Name` INT, `Phone` INT, `Order_ID` INT, `Quantity` INT, `Cuisine` INT, `Food_Type` INT, `Price` INT, `Payment_Type` INT, `Remarks` INT);

-- -----------------------------------------------------
-- Placeholder table for view `little_lemon_db`.`table_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`table_status` (`CUSTOMER` INT, `PHONE` INT, `TABLE_NO` INT, `PRESENT_STATUS` INT, `TIME_BOOKED` INT);

-- -----------------------------------------------------
-- procedure auto_update_bookings
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `auto_update_bookings`(
  IN new_booking_id int,
  IN new_name varchar(35),
  IN new_phone_no varchar(25),
  IN new_email varchar(35)
)
BEGIN
		UPDATE Bookings
    SET name = new_name, phone_no = new_phone_no, email = new_email
    WHERE booking_id = new_booking_id;
    -- this code will also update the data in the customers table
    UPDATE Customers
    SET customer_name = new_name, phone_number = new_phone_no, email = new_email
    WHERE booking_no = new_booking_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure bookings_deletion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bookings_deletion`(IN targeted_booking_id int)
BEGIN
		DELETE FROM bookings WHERE booking_id = targeted_booking_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure bookings_insertion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bookings_insertion`(
	IN new_booking_slot datetime,
  IN new_name varchar(45),
	IN new_phone_no varchar(25),
	IN new_email varchar(35),
	IN new_table_no int 
	)
BEGIN
		INSERT INTO Bookings(booking_slot,name,phone_no,email,table_no)
    VALUES (new_booking_slot, new_name, new_phone_no, new_email, new_table_no);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure menu_deletion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_deletion`(IN old_menu_id int)
BEGIN
		DELETE FROM menus WHERE menu_id = old_menu_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure menu_insertion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_insertion`(
  IN new_cuisine varchar(25),
	IN new_food_type varchar(25),
	IN new_price float,
	IN new_chefs_comment varchar(55)
)
BEGIN 
	INSERT INTO menus(cuisine, food_type, price, chefs_comment)
  VALUES (new_cuisine, new_food_type, new_price, new_chefs_comment);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure menu_updation
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_updation`(
  IN old_menu_id int,
	IN new_cuisine varchar(25),
	IN new_food_type varchar(15),
	IN new_price float,
	IN new_chefs_comment varchar(55)
	)
BEGIN
		UPDATE menus
    SET cuisine = new_cuisine, food_type = new_food_type, price = new_price, chefs_comment = new_chefs_comment
    WHERE menu_id = old_menu_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure orders_deletion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `orders_deletion`(IN old_order_id int)
BEGIN
		DELETE FROM orders WHERE order_id = old_order_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure orders_insertion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `orders_insertion`(
  IN new_customer_id int,
  IN new_menu_no int,
  IN new_quantity int
  )
BEGIN
		INSERT INTO orders(customer_id,menu_no,quantity)
    VALUES (new_customer, new_menu_no, new_quantity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure orders_updation
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `orders_updation`(
  IN new_order_id int,
	IN new_customer_id int,
	IN new_menu_no int,
	IN new_quantity int)
BEGIN
		UPDATE orders
    SET customer_id = new_customer_id, menu_no = new_menu_no, quantity = new_quantity
    WHERE order_id = new_order_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure staffs_deletion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `staffs_deletion`(IN targeted_staff_id int)
BEGIN 
		DELETE FROM staffs WHERE staff_id = targeted_staff_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure staffs_insertion
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `staffs_insertion`(
  IN new_name varchar(35),
	IN new_email varchar(45),
	IN new_ph_no varchar(20),
	IN new_address varchar(55)
	)
BEGIN  
		INSERT INTO staffs(name, email, ph_no, address) 
    VALUES (new_name, new_email, new_ph_no, new_address);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure staffs_updation
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `staffs_updation`(
	IN targeted_staff_id int,
	IN new_name varchar(35),
	IN new_email varchar(55),
	IN new_ph_no varchar(25),
	IN new_address varchar(55)
	)
BEGIN
		UPDATE staffs
    SET name = new_name, email = new_email, ph_no = new_ph_no, address = new_address
    WHERE staff_id = targeted_staff_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `little_lemon_db`.`important_details_online`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`important_details_online`;
USE `little_lemon_db`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `little_lemon_db`.`important_details_online` AS select `little_lemon_db`.`customers`.`customer_name` AS `Name`,`little_lemon_db`.`customers`.`phone_number` AS `Phone`,`little_lemon_db`.`orders`.`order_id` AS `Order_ID`,`little_lemon_db`.`orders`.`quantity` AS `Quantity`,`little_lemon_db`.`menus`.`cuisine` AS `Cuisine`,`little_lemon_db`.`menus`.`food_type` AS `Food_Type`,`little_lemon_db`.`menus`.`price` AS `Price`,`little_lemon_db`.`payments`.`payment_type` AS `Payment_Type`,`little_lemon_db`.`payments`.`remarks` AS `Remarks` from (((`little_lemon_db`.`customers` join `little_lemon_db`.`orders` on((`little_lemon_db`.`orders`.`customer_id` = `little_lemon_db`.`customers`.`customer_id`))) join `little_lemon_db`.`menus` on((`little_lemon_db`.`menus`.`menu_id` = `little_lemon_db`.`orders`.`menu_no`))) join `little_lemon_db`.`payments` on((`little_lemon_db`.`payments`.`order_no` = `little_lemon_db`.`orders`.`order_id`)));

-- -----------------------------------------------------
-- View `little_lemon_db`.`table_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`table_status`;
USE `little_lemon_db`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `little_lemon_db`.`table_status` AS select `little_lemon_db`.`bookings`.`name` AS `CUSTOMER`,`little_lemon_db`.`bookings`.`phone_no` AS `PHONE`,`little_lemon_db`.`tables_`.`table_number` AS `TABLE_NO`,`little_lemon_db`.`tables_`.`availability` AS `PRESENT_STATUS`,`little_lemon_db`.`tables_`.`booking_time` AS `TIME_BOOKED` from (`little_lemon_db`.`bookings` join `little_lemon_db`.`tables_` on((`little_lemon_db`.`tables_`.`table_number` = `little_lemon_db`.`bookings`.`table_no`)));
USE `little_lemon_db`;

DELIMITER $$
USE `little_lemon_db`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `little_lemon_db`.`bookings_deletion`
AFTER DELETE ON `little_lemon_db`.`bookings`
FOR EACH ROW
BEGIN
		DELETE FROM Customers WHERE booking_no = OLD.booking_id;
END$$

USE `little_lemon_db`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `little_lemon_db`.`bookings_insertion`
AFTER INSERT ON `little_lemon_db`.`bookings`
FOR EACH ROW
BEGIN
		INSERT INTO Customers(booking_no,Customer_name,phone_number,email) 
    VALUES (NEW.booking_id,NEW.name,NEW.phone_no,NEW.email);
END$$

USE `little_lemon_db`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `little_lemon_db`.`tables_deletion`
AFTER DELETE ON `little_lemon_db`.`bookings`
FOR EACH ROW
BEGIN
    UPDATE tables_
    SET 
        availability = "Available", 
        booking_no = NULL, 
        booking_time = NULL
    WHERE table_number = OLD.table_no;
END$$

USE `little_lemon_db`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `little_lemon_db`.`tables_insertion`
AFTER INSERT ON `little_lemon_db`.`bookings`
FOR EACH ROW
BEGIN
    UPDATE tables_
    SET 	
    			availability = "Not Available", 
       	 	booking_no = NEW.booking_id, 
        	booking_time = NEW.booking_slot
    WHERE table_number = NEW.table_no;
END$$

USE `little_lemon_db`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `little_lemon_db`.`tables_updation`
AFTER UPDATE ON `little_lemon_db`.`bookings`
FOR EACH ROW
BEGIN
    UPDATE tables_
    SET 
        availability = "Not Available", 
        booking_no = NEW.booking_id, 
        booking_time = NEW.booking_slot
    WHERE table_number = NEW.table_no;
END$$

USE `little_lemon_db`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `little_lemon_db`.`after_payment`
AFTER INSERT ON `little_lemon_db`.`payments`
FOR EACH ROW
BEGIN
		UPDATE tables_
    SET 
    	availability = "Available",
      booking_no = null,
      booking_time = null
    WHERE table_number = NEW.table_no;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
