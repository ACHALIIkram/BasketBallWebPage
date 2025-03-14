-- -----------------------------------------------------
-- Table `techballerdb`.`Training`
-- -----------------------------------------------------


-- CREATE TABLE IF NOT EXISTS `techballerdb`.`Training` (
--   `idTraining` INT NOT NULL AUTO_INCREMENT,
--   `WeekDay` INT NOT NULL CHECK ( `WeekDay` BETWEEN 1 AND 7),
--   `StartHour` TIME NOT NULL CHECK( HOUR(`StartHour`) BETWEEN 6 AND 23) ,
--   `EndHour` TIME NOT NULL CHECK( HOUR(`EndHour`) BETWEEN 6 AND 23),
--   `Place` VARCHAR(45) NOT NULL,
--   `idTeam` INT NOT NULL,
--   PRIMARY KEY (`idTraining`),
--   CONSTRAINT `fk_Training_Team`
--     FOREIGN KEY (`idTeam`)
--     REFERENCES `techballerdb`.`Team` (`idTeam`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE);

CREATE TABLE `sql7748686`.`Training` (
  `idTraining` INT NOT NULL AUTO_INCREMENT , 
  `WeekDay` INT NULL DEFAULT NULL , 
  `StartHour` TIME NULL , 
  `EndHour` TIME NULL , 
  `Place` VARCHAR(45) NULL , 
  `idTeam` INT NULL , 
  PRIMARY KEY (`idTraining`))
ENGINE = InnoDB;

INSERT INTO `techballerdb`.`Team` (`Name`, `NbPlayers`, `TrainingDates`, `TrainingPlace`, `RegistrationFee`)
VALUES
('Poussins 2e année', '12', 'Monday', 'Gymnase Mimoun', '175 EUR'),
('Benjamines', '10', 'Monday', 'Jeu de Paume', '180 EUR'),
('Minimes Garçons', '14', 'Monday, Wednesday', 'Mimoun', '180 EUR'),
('Seniors Garçons', '15', 'Monday, Thursday', 'Bourneton', '200 EUR'),
('Minimes Filles', '13', 'Tuesday, Sunday', 'Jeu de Paume', '180 EUR'),
('Cadettes', '11', 'Tuesday, Friday', 'Mimoun', '175 EUR'),
('Seniors Filles', '14', 'Tuesday, Thursday', 'Jeu de Paume', '200 EUR'),
('Poussin 1er année', '10', 'Wednesday', 'Mimoun', '175 EUR'),
('Benjamins', '12', 'Wednesday', 'Jeu de Paume', '180 EUR'),
('Cadets', '13', 'Wednesday, Friday', 'Jeu de Paume', '175 EUR'),
('Benjamines Garçons', '12', 'Friday', 'Mimoun', '180 EUR'),
('Détente', '10', 'Friday', 'Jeu de Paume', '130 EUR');

INSERT INTO `techballerdb`.`Training` (`WeekDay`, `StartHour`, `EndHour`, `Place`, `idTeam`) 
VALUES
-- Lundi
(1, '17:30:00', '18:45:00', 'Gymnase Mimoun', 11),
(1, '17:45:00', '19:15:00', 'Jeu de Paume', 12),
(1, '18:45:00', '20:00:00', 'Mimoun', 13),
(1, '21:00:00', '22:30:00', 'Bourneton', 14),

-- Mardi
(2, '17:45:00', '19:00:00', 'Jeu de Paume', 15),
(2, '19:15:00', '20:30:00', 'Mimoun', 16),
(2, '20:00:00', '22:30:00', 'Jeu de Paume',17),

-- Mercredi
(3, '15:30:00', '17:00:00', 'Mimoun', 18),
(3, '17:30:00', '18:45:00', 'Mimoun', 11),
(3, '17:45:00', '19:30:00', 'Jeu de Paume', 19),
(3, '18:45:00', '20:00:00', 'Mimoun', 13),
(3, '19:30:00', '21:00:00', 'Jeu de Paume', 20),

-- Jeudi
(4, '20:00:00', '22:30:00', 'Jeu de Paume', 14),
(4, '20:30:00', '22:30:00', 'Bourneton', 17),

-- Vendredi
(5, '18:45:00', '20:00:00', 'Mimoun', 21),
(5, '18:00:00', '19:30:00', 'Jeu de Paume', 15),
(5, '19:30:00', '21:00:00', 'Jeu de Paume', 20),
(5, '20:30:00', '22:30:00', 'Bourneton', 16),
(5, '21:00:00', '22:30:00', 'Jeu de Paume', 22),

-- Dimanche
(7, '17:45:00', '19:00:00', 'Jeu de Paume', 15);

-- CREATE TABLE `sql7746392`.`Trainning` 
-- ( `idTraining` INT NOT NULL AUTO_INCREMENT, `WeekDay` INT NOT NULL, `StartHour` TIME NOT NULL, `EndHour` TIME NOT NULL, `Place` VARCHAR(255) NULL DEFAULT NULL, `idTeam` INT NULL DEFAULT NULL , PRIMARY KEY (`idTraining`), CONSTRAINT `fk_Training_Team`
--     FOREIGN KEY (`idTeam`)
--     REFERENCES `techballerdb`.`Team` (`idTeam`)) ENGINE = InnoDB;