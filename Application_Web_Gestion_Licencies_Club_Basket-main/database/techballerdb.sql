
CREATE DATABASE techballerdb;

USE techballerdb;

DROP TABLE IF EXISTS `techballerdb`.`Player` ;
DROP TABLE IF EXISTS `techballerdb`.`Admin` ;
DROP TABLE IF EXISTS `techballerdb`.`User` ;
DROP TABLE IF EXISTS `techballerdb`.`Statistics` ;
DROP TABLE IF EXISTS `techballerdb`.`Match` ;
DROP TABLE IF EXISTS `techballerdb`.`Team` ;

CREATE TABLE IF NOT EXISTS `techballerdb`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(200) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`));

-- -----------------------------------------------------
-- Table `techballerdb`.`Admin`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `techballerdb`.`Admin` (
  `idAdmin` INT NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdmin`),
  CONSTRAINT `fk_iduser_admin`
    FOREIGN KEY (`idAdmin`)
    REFERENCES `techballerdb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `techballerdb`.`Statistics`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `techballerdb`.`Statistics` (
  `idStat` INT NOT NULL AUTO_INCREMENT,
  `Rebounds` INT NOT NULL,
  `Points` INT NOT NULL,
  `3PtsFieldGoalsMade` INT NOT NULL,
  `3PtsFieldGoalsAttempted` INT NOT NULL,
  `FreeThrowMade` INT NOT NULL,
  `FreeThrowAttempted` INT NOT NULL,
  PRIMARY KEY (`idStat`));

-- -----------------------------------------------------
-- Table `techballerdb`.`Player`
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS `techballerdb`.`Player` (
  `idUser` INT NOT NULL,
  `idStat` INT NULL,
  PRIMARY KEY(`idUser`),
  CONSTRAINT `fk_idStat_player`
    FOREIGN KEY (`idStat`)
    REFERENCES `techballerdb`.`Statistics` (`idStat`),
  CONSTRAINT `fk_idUser_player`
    FOREIGN KEY (`idUser`)
    REFERENCES `techballerdb`.`User` (`idUser`));


-- -----------------------------------------------------
-- Table `techballerdb`.`Match`
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS `techballerdb`.`Match` (
  `idMatch` INT NOT NULL AUTO_INCREMENT,
  `Championship` VARCHAR(45) NOT NULL,
  `Stage` VARCHAR(45) NOT NULL,
  `Score` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Place` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMatch`));

-- -----------------------------------------------------
-- Table `techballerdb`.`Team`
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS `techballerdb`.`Team` (
  `idTeam` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `NbPlayers` VARCHAR(45) NOT NULL,
  `TrainingDates` TEXT NOT NULL,
  `TrainingPlace` VARCHAR(45) NOT NULL,
  `RegistrationFee` TEXT NOT NULL,
  PRIMARY KEY (`idTeam`));