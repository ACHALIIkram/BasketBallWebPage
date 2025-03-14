
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





  -- -----------------------------------------------------
-- Table `techballerdb`.`Match`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`Match` (`Championship`, `Stage`, `Score`, `Date`, `Place`) VALUES 
('NBA Finals', 'Game 1', 102, '2024-06-01', 'Madison Square Garden'),
('EuroLeague', 'Semifinal', 89, '2024-05-20', 'O2 Arena'),
('WNBA Finals', 'Game 3', 95, '2024-06-05', 'Staples Center'),
('Olympics', 'Quarterfinal', 78, '2024-07-25', 'Tokyo Dome'),
('FIBA World Cup', 'Group Stage', 86, '2023-09-10', 'Mall of Asia Arena'),
('NBA Playoffs', 'Round 1 - Game 7', 110, '2024-04-15', 'Chase Center'),
('High School Championship', 'Final', 75, '2024-03-12', 'United Center'),
('College Basketball', 'Sweet 16', 81, '2024-03-28', 'Lucas Oil Stadium'),
('Summer League', 'Exhibition', 94, '2024-08-01', 'Thomas & Mack Center'),
('All-Star Game', 'Exhibition', 130, '2024-02-18', 'Barclays Center');

-- -----------------------------------------------------
-- Table `techballerdb`.`Statistics`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`Statistics` 
(`Rebounds`, `Points`, `3PtsFieldGoalsMade`, `3PtsFieldGoalsAttempted`, `FreeThrowMade`, `FreeThrowAttempted`) 
VALUES
(10, 25, 4, 8, 3, 4),  -- Match avec une performance solide : 10 rebonds, 25 points, 50% à 3 points
( 8, 18, 2, 6, 4, 5),   -- Match moyen : 8 rebonds, 18 points, difficultés aux lancers francs
(15, 30, 5, 9, 6, 7),  -- Excellent match : domination au score et aux rebonds
(6, 12, 1, 4, 2, 2),   -- Match discret avec peu de tirs à 3 points tentés
(12, 22, 3, 7, 5, 6),  -- Bonne performance globale
(20, 35, 6, 10, 8, 9), -- Performance exceptionnelle : beaucoup de rebonds et de points
(7, 14, 2, 5, 4, 4),   -- Match équilibré
(5, 10, 0, 3, 1, 3),   -- Match difficile : seulement 10 points et faible réussite
(13, 28, 4, 8, 7, 8),  -- Match complet : contribution dans plusieurs catégories
(18, 40, 7, 11, 10, 12); -- Explosif : score impressionnant et bonne adresse

-- -----------------------------------------------------
-- Table `techballerdb`.`User`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`User` (`FirstName`, `LastName`) VALUES
('LeBron', 'James'),
('Stephen', 'Curry'),
('Kevin', 'Durant'),
('Giannis', 'Antetokounmpo'),
('Kawhi', 'Leonard'),
('Luka', 'Doncic'),
('Jayson', 'Tatum'),
('Joel', 'Embiid'),
('Damian', 'Lillard'),
('Nikola', 'Jokic'),
('Steve', 'Kerr'),
('Erik', 'Spoelstra'),
('Doc', 'Rivers'),
('Gregg', 'Popovich'),
('Nick', 'Nurse');

-- -----------------------------------------------------
-- Table `techballerdb`.`Player`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`Player` (`idUser`, `idStat`) VALUES
(1, 2),
(2, 3),
(3, 6),
(4, 1),
(5, 5),
(6, 3),
(7, 7),
(8, 2),
(9, 5),
(10, 4),
(11, 3),
(12, 9),
(13, 5),
(14, 7);

-- -----------------------------------------------------
-- Table `techballerdb`.`Admin`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`Admin` (`idAdmin`,`login`, `Password`) VALUES
(1, 'lebron', 'lebron' ),
(2, 'stephen', 'stephen'),
(3, 'kevin', 'kevin');

-- -----------------------------------------------------
-- Table `techballerdb`.`Team`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`Team` 
(`Name`, `NbPlayers`, `TrainingDates`, `TrainingPlace`, `RegistrationFee`) 
VALUES
('Lakers', '15', 'Lundi et Mercredi de 18h00 à 20h00', 'Crypto.com Arena', '1000 USD'),
('Warriors', '14', 'Mardi et Jeudi de 17h00 à 19h00', 'Chase Center', '1200 USD'),
('Nets', '16', 'Lundi, Mercredi et Vendredi de 16h00 à 18h00', 'Barclays Center', '1100 USD'),
('Celtics', '14', 'Mardi et Vendredi de 18h00 à 20h00', 'TD Garden', '900 USD'),
('Bucks', '15', 'Lundi et Jeudi de 19h00 à 21h00', 'Fiserv Forum', '1000 USD'),
('Heat', '12', 'Lundi et Mercredi de 20h00 à 22h00', 'FTX Arena', '950 USD'),
('Suns', '13', 'Mardi et Jeudi de 18h30 à 20h30', 'Footprint Center', '1050 USD'),
('Raptors', '14', 'Lundi et Vendredi de 17h30 à 19h30', 'Scotiabank Arena', '980 USD'),
('76ers', '15', 'Mercredi et Samedi de 16h00 à 18h00', 'Wells Fargo Center', '1020 USD'),
('Spurs', '13', 'Mardi et Jeudi de 19h00 à 21h00', 'AT&T Center', '850 USD');