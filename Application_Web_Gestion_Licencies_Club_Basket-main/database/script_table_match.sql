-- -----------------------------------------------------
-- Table `techballerdb`.`Match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `techballerdb`.`Match` ;

CREATE TABLE IF NOT EXISTS `techballerdb`.`Match` (
  `idMatch` INT NOT NULL AUTO_INCREMENT,
  `Championship` VARCHAR(45) NOT NULL,
  `Stage` VARCHAR(45) NOT NULL,
  `Score` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `Place` VARCHAR(45) NOT NULL,
  `Description` TEXT NOT NULL,
  PRIMARY KEY (`idMatch`));