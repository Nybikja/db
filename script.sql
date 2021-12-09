CREATE DATABASE IF NOT EXISTS `lab7`;
USE `lab7`;

DROP TABLE IF EXISTS marker;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS passwords;
DROP TABLE IF EXISTS link;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS catalog_tree;


CREATE TABLE `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  `date_of_birth` DATE NULL,
  `place_of_birth` VARCHAR(45) NULL,
  `place_of_residence` VARCHAR(45) NULL,
  `note` VARCHAR(45) NULL,
  `rating` INT NULL,
  PRIMARY KEY (`id`)
  );

CREATE TABLE `passwords` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
  );

CREATE TABLE `book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `UDC` VARCHAR(100) NULL,
  `rating` INT NULL,
  `catalog_tree_id` INT NOT NULL,
  PRIMARY KEY (`id`)
  );

CREATE TABLE `catalog_tree` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rubrik` VARCHAR(45) NULL,
  `parent_catalog_id` INT NOT NULL,
  PRIMARY KEY (`id`)
    );


CREATE TABLE `link` (
  `id` INT NOT NULL,
  `book_email` VARCHAR(45) NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`id`)
  );

CREATE TABLE `marker` (
  `book_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `user_id`)
  );
