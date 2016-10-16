-- MySQL Script generated by MySQL Workbench
-- su 16. lokakuuta 2016 22.21.54
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema wordSystem
-- -----------------------------------------------------
-- Database for online word training system for Vaadin course.
DROP SCHEMA IF EXISTS `wordSystem` ;

-- -----------------------------------------------------
-- Schema wordSystem
--
-- Database for online word training system for Vaadin course.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wordSystem` DEFAULT CHARACTER SET utf8 ;
USE `wordSystem` ;

-- -----------------------------------------------------
-- Table `wordSystem`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordSystem`.`User` ;

CREATE TABLE IF NOT EXISTS `wordSystem`.`User` (
  `idUser` INT NOT NULL COMMENT 'User id',
  `date` DATE NOT NULL,
  `passwd` VARCHAR(255) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
COMMENT = 'Table representing the user of the system';


-- -----------------------------------------------------
-- Table `wordSystem`.`Language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordSystem`.`Language` ;

CREATE TABLE IF NOT EXISTS `wordSystem`.`Language` (
  `idLanguage` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idLanguage`))
ENGINE = InnoDB
COMMENT = 'Table which represents a language in the system which words can be referenced to.';


-- -----------------------------------------------------
-- Table `wordSystem`.`Word`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordSystem`.`Word` ;

CREATE TABLE IF NOT EXISTS `wordSystem`.`Word` (
  `idWord` INT NOT NULL,
  `idMaster` INT NULL DEFAULT NULL,
  `idLang` INT NOT NULL,
  PRIMARY KEY (`idWord`),
  INDEX `fk_language_idx` (`idLang` ASC),
  INDEX `fk_masterWord_idx` (`idMaster` ASC),
  CONSTRAINT `fk_masterWord`
    FOREIGN KEY (`idMaster`)
    REFERENCES `wordSystem`.`Word` (`idWord`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_language`
    FOREIGN KEY (`idLang`)
    REFERENCES `wordSystem`.`Language` (`idLanguage`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'The table which represents a word in the dictionary. A word can be of any language and it\'s linked to it\'s explanation/master word in Finnish.';


-- -----------------------------------------------------
-- Table `wordSystem`.`List`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordSystem`.`List` ;

CREATE TABLE IF NOT EXISTS `wordSystem`.`List` (
  `idList` INT NOT NULL,
  `creator` INT NOT NULL,
  PRIMARY KEY (`idList`),
  INDEX `fk_creator_idx` (`creator` ASC),
  CONSTRAINT `fk_creator`
    FOREIGN KEY (`creator`)
    REFERENCES `wordSystem`.`User` (`idUser`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'List which is a composition of word entries which the user can train with.';


-- -----------------------------------------------------
-- Table `wordSystem`.`WordEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordSystem`.`WordEntry` ;

CREATE TABLE IF NOT EXISTS `wordSystem`.`WordEntry` (
  `idWord` INT NOT NULL,
  `idList` INT NOT NULL,
  PRIMARY KEY (`idWord`, `idList`),
  INDEX `fk_list_idx` (`idList` ASC),
  CONSTRAINT `fk_list`
    FOREIGN KEY (`idList`)
    REFERENCES `wordSystem`.`List` (`idList`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_word`
    FOREIGN KEY (`idWord`)
    REFERENCES `wordSystem`.`Word` (`idWord`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Word entry in a list, relation between word and a list';


-- -----------------------------------------------------
-- Table `wordSystem`.`Result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordSystem`.`Result` ;

CREATE TABLE IF NOT EXISTS `wordSystem`.`Result` (
  `idResult` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `idUser` INT NOT NULL,
  `score` INT NULL DEFAULT 0,
  `idLang` INT NULL,
  PRIMARY KEY (`idResult`),
  INDEX `fk_lang_idx` (`idLang` ASC),
  INDEX `fk_user_idx` (`idUser` ASC),
  CONSTRAINT `fk_lang`
    FOREIGN KEY (`idLang`)
    REFERENCES `wordSystem`.`Language` (`idLanguage`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`idUser`)
    REFERENCES `wordSystem`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'A result from a single run of the game, used for tracking user\'s progress';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;