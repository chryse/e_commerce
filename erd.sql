-- MySQL Script generated by MySQL Workbench
-- Sat Feb  7 16:27:15 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`categories` ;

CREATE TABLE IF NOT EXISTS `mydb`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`products` ;

CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `desc` VARCHAR(45) NULL,
  `price` DOUBLE NULL,
  `inventory` VARCHAR(45) NULL,
  `main_image` VARCHAR(45) NULL,
  `image_path_1` VARCHAR(45) NULL,
  `image_path_2` VARCHAR(45) NULL,
  `image_path_3` VARCHAR(45) NULL,
  `categories_id` INT NOT NULL,
  PRIMARY KEY (`id`, `categories_id`),
  INDEX `fk_products_categories1_idx` (`categories_id` ASC),
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `mydb`.`categories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`locations` ;

CREATE TABLE IF NOT EXISTS `mydb`.`locations` (
  `id` INT NOT NULL,
  `city_name` VARCHAR(255) NULL,
  `state_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`billing_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`billing_address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`billing_address` (
  `id` INT NOT NULL,
  `address1` VARCHAR(255) NULL,
  `address2` VARCHAR(255) NULL,
  `locations_id` INT NOT NULL,
  PRIMARY KEY (`id`, `locations_id`),
  INDEX `fk_billing_address_locations1_idx` (`locations_id` ASC),
  CONSTRAINT `fk_billing_address_locations1`
    FOREIGN KEY (`locations_id`)
    REFERENCES `mydb`.`locations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ship_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ship_address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ship_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address1` VARCHAR(255) NULL,
  `address2` VARCHAR(45) NULL,
  `locations_id` INT NOT NULL,
  `billing_address_same` TINYINT(1) NULL,
  `billing_address_id` INT NOT NULL,
  `billing_address_locations_id` INT NOT NULL,
  PRIMARY KEY (`id`, `locations_id`),
  INDEX `fk_ship_address_locations1_idx` (`locations_id` ASC),
  INDEX `fk_ship_address_billing_address1_idx` (`billing_address_id` ASC, `billing_address_locations_id` ASC),
  CONSTRAINT `fk_ship_address_locations1`
    FOREIGN KEY (`locations_id`)
    REFERENCES `mydb`.`locations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ship_address_billing_address1`
    FOREIGN KEY (`billing_address_id` , `billing_address_locations_id`)
    REFERENCES `mydb`.`billing_address` (`id` , `locations_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `ship_address_id` INT NOT NULL,
  `ship_address_locations_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_ship_address1_idx` (`ship_address_id` ASC, `ship_address_locations_id` ASC),
  CONSTRAINT `fk_customers_ship_address1`
    FOREIGN KEY (`ship_address_id` , `ship_address_locations_id`)
    REFERENCES `mydb`.`ship_address` (`id` , `locations_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`orders` ;

CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_count` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `customers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_customers1_idx` (`customers_id` ASC),
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `mydb`.`customers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders_has_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`orders_has_products` ;

CREATE TABLE IF NOT EXISTS `mydb`.`orders_has_products` (
  `orders_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  PRIMARY KEY (`orders_id`, `products_id`),
  INDEX `fk_orders_has_products_products1_idx` (`products_id` ASC),
  INDEX `fk_orders_has_products_orders_idx` (`orders_id` ASC),
  CONSTRAINT `fk_orders_has_products_orders`
    FOREIGN KEY (`orders_id`)
    REFERENCES `mydb`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_has_products_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `mydb`.`products` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
