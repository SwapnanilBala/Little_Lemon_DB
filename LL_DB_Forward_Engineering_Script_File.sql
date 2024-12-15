-- MySQL Script generated by MySQL Workbench
-- Sun Dec 15 16:26:48 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `Customer_ID` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 50
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bookings` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bookings` (
  `Booking_ID` INT NOT NULL AUTO_INCREMENT,
  `Customer_ID` INT NOT NULL,
  `Booking_Time` DATETIME NOT NULL,
  `Total_Customers` INT NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  INDEX `Customer_ID_idx` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `mydb`.`customers` (`Customer_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`menu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`menu` (
  `Menu_ID` INT NOT NULL,
  `Cuisine` VARCHAR(45) NOT NULL,
  `Food_Name` VARCHAR(45) NOT NULL,
  `Food_Type` VARCHAR(45) NOT NULL,
  `Price` FLOAT NOT NULL,
  `Discount` FLOAT NOT NULL,
  PRIMARY KEY (`Menu_ID`),
  INDEX `Order_ID_idx` (`Menu_ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `Table_No` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Feedback` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Table_No`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`payment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
  `Payment_ID` INT NOT NULL AUTO_INCREMENT,
  `Order_ID` INT NOT NULL,
  `Total_Amount` FLOAT NOT NULL,
  `Payment_Type` VARCHAR(10) NOT NULL,
  `Feedback` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Payment_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`staff_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`staff_details` ;

CREATE TABLE IF NOT EXISTS `mydb`.`staff_details` (
  `Staff_Details_ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone_No` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Staff_Details_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`staff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `Staff_ID` INT NOT NULL,
  `Staff_info_ID` INT NOT NULL,
  `Availability` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Staff_ID`),
  INDEX `Staff_Details_ID_idx` (`Staff_info_ID` ASC) VISIBLE,
  CONSTRAINT `Staff_Details_ID`
    FOREIGN KEY (`Staff_info_ID`)
    REFERENCES `mydb`.`staff_details` (`Staff_Details_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`orders` ;

CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `Order_ID` INT NOT NULL AUTO_INCREMENT,
  `Booking_ID` INT NOT NULL,
  `Payment_ID` INT NOT NULL,
  `Menu_ID` INT NOT NULL,
  `Staff_ID` INT NOT NULL,
  `Table_No` INT NOT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Booking_ID_idx` (`Booking_ID` ASC) VISIBLE,
  INDEX `Table_No_idx` (`Table_No` ASC) VISIBLE,
  INDEX `Payment_ID_idx` (`Payment_ID` ASC) VISIBLE,
  INDEX `Menu_ID_idx` (`Menu_ID` ASC) VISIBLE,
  INDEX `Staff_ID_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `Booking_ID`
    FOREIGN KEY (`Booking_ID`)
    REFERENCES `mydb`.`bookings` (`Booking_ID`),
  CONSTRAINT `Table_No`
    FOREIGN KEY (`Table_No`)
    REFERENCES `mydb`.`status` (`Table_No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Payment_ID`
    FOREIGN KEY (`Payment_ID`)
    REFERENCES `mydb`.`payment` (`Payment_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Menu_ID`
    FOREIGN KEY (`Menu_ID`)
    REFERENCES `mydb`.`menu` (`Menu_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Staff_ID`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `mydb`.`staff` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
