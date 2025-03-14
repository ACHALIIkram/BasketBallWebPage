-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Hôte : sql7.freesqldatabase.com
-- Généré le :  sam. 30 nov. 2024 à 11:56
-- Version du serveur :  5.5.62-0ubuntu0.14.04.1
-- Version de PHP :  7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `sql7748686`
--

-- --------------------------------------------------------

--
-- Structure de la table `Admin`
--

CREATE TABLE `Admin` (
  `idAdmin` int(11) NOT NULL,
  `login` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `Admin`
--

INSERT INTO `Admin` (`idAdmin`, `login`, `Password`) VALUES
(1, 'lebron', 'lebron'),
(2, 'stephen', 'stephen'),
(3, 'kevin', 'kevin');

-- --------------------------------------------------------

--
-- Structure de la table `Match`
--

CREATE TABLE `Match` (
  `idMatch` int(11) NOT NULL,
  `Championship` varchar(45) NOT NULL,
  `Stage` varchar(45) NOT NULL,
  `Score` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Place` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `Match`
--

INSERT INTO `Match` (`idMatch`, `Championship`, `Stage`, `Score`, `Date`, `Place`) VALUES
(1, 'NBA Finals', 'Game 1', 102, '2024-06-01', 'Madison Square Garden'),
(2, 'EuroLeague', 'Semifinal', 89, '2024-05-20', 'O2 Arena'),
(3, 'WNBA Finals', 'Game 3', 95, '2024-06-05', 'Staples Center'),
(4, 'Olympics', 'Quarterfinal', 78, '2024-07-25', 'Tokyo Dome'),
(5, 'FIBA World Cup', 'Group Stage', 86, '2023-09-10', 'Mall of Asia Arena'),
(6, 'NBA Playoffs', 'Round 1 - Game 7', 110, '2024-04-15', 'Chase Center'),
(7, 'High School Championship', 'Final', 75, '2024-03-12', 'United Center'),
(8, 'College Basketball', 'Sweet 16', 81, '2024-03-28', 'Lucas Oil Stadium'),
(9, 'Summer League', 'Exhibition', 94, '2024-08-01', 'Thomas & Mack Center'),
(10, 'All-Star Game', 'Exhibition', 130, '2024-02-18', 'Barclays Center'),
(11, 'NBA Finals', 'Game 1', 102, '2024-06-01', 'Madison Square Garden'),
(12, 'EuroLeague', 'Semifinal', 89, '2024-05-20', 'O2 Arena'),
(13, 'WNBA Finals', 'Game 3', 95, '2024-06-05', 'Staples Center'),
(14, 'Olympics', 'Quarterfinal', 78, '2024-07-25', 'Tokyo Dome'),
(15, 'FIBA World Cup', 'Group Stage', 86, '2023-09-10', 'Mall of Asia Arena'),
(16, 'NBA Playoffs', 'Round 1 - Game 7', 110, '2024-04-15', 'Chase Center'),
(17, 'High School Championship', 'Final', 75, '2024-03-12', 'United Center'),
(18, 'College Basketball', 'Sweet 16', 81, '2024-03-28', 'Lucas Oil Stadium'),
(19, 'Summer League', 'Exhibition', 94, '2024-08-01', 'Thomas & Mack Center'),
(20, 'All-Star Game', 'Exhibition', 130, '2024-02-18', 'Barclays Center');

-- --------------------------------------------------------

--
-- Structure de la table `Player`
--

CREATE TABLE `Player` (
  `idUser` int(11) NOT NULL,
  `idStat` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `Player`
--

INSERT INTO `Player` (`idUser`, `idStat`) VALUES
(4, 1),
(1, 2),
(8, 2),
(2, 3),
(6, 3),
(11, 3),
(10, 4),
(5, 5),
(9, 5),
(13, 5),
(3, 6),
(7, 7),
(14, 7),
(12, 9);

-- --------------------------------------------------------

--
-- Structure de la table `Statistics`
--

CREATE TABLE `Statistics` (
  `idStat` int(11) NOT NULL,
  `Rebounds` int(11) NOT NULL,
  `Points` int(11) NOT NULL,
  `ThreePtsFieldGoalsMade` int(11) DEFAULT NULL,
  `ThreePtsFieldGoalsAttempted` int(11) DEFAULT NULL,
  `FreeThrowMade` int(11) NOT NULL,
  `FreeThrowAttempted` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `Statistics`
--

INSERT INTO `Statistics` (`idStat`, `Rebounds`, `Points`, `ThreePtsFieldGoalsMade`, `ThreePtsFieldGoalsAttempted`, `FreeThrowMade`, `FreeThrowAttempted`) VALUES
(1, 10, 25, 4, 8, 3, 4),
(2, 8, 18, 2, 6, 4, 5),
(3, 15, 30, 5, 9, 6, 7),
(4, 6, 12, 1, 4, 2, 2),
(5, 12, 22, 3, 7, 5, 6),
(6, 20, 35, 6, 10, 8, 9),
(7, 7, 14, 2, 5, 4, 4),
(8, 5, 10, 0, 3, 1, 3),
(9, 13, 28, 4, 8, 7, 8),
(10, 18, 40, 7, 11, 10, 12);

-- --------------------------------------------------------

--
-- Structure de la table `Team`
--

CREATE TABLE `Team` (
  `idTeam` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `NbPlayers` varchar(45) NOT NULL,
  `TrainingDates` text NOT NULL,
  `TrainingPlace` varchar(45) NOT NULL,
  `RegistrationFee` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `Team`
--

INSERT INTO `Team` (`idTeam`, `Name`, `NbPlayers`, `TrainingDates`, `TrainingPlace`, `RegistrationFee`) VALUES
(1, 'Lakers', '15', 'Lundi et Mercredi de 18h00 à 20h00', 'Crypto.com Arena', '1000 USD'),
(2, 'Warriors', '14', 'Mardi et Jeudi de 17h00 à 19h00', 'Chase Center', '1200 USD'),
(3, 'Nets', '16', 'Lundi, Mercredi et Vendredi de 16h00 à 18h00', 'Barclays Center', '1100 USD'),
(4, 'Celtics', '14', 'Mardi et Vendredi de 18h00 à 20h00', 'TD Garden', '900 USD'),
(5, 'Bucks', '15', 'Lundi et Jeudi de 19h00 à 21h00', 'Fiserv Forum', '1000 USD'),
(6, 'Heat', '12', 'Lundi et Mercredi de 20h00 à 22h00', 'FTX Arena', '950 USD'),
(7, 'Suns', '13', 'Mardi et Jeudi de 18h30 à 20h30', 'Footprint Center', '1050 USD'),
(8, 'Raptors', '14', 'Lundi et Vendredi de 17h30 à 19h30', 'Scotiabank Arena', '980 USD'),
(9, '76ers', '15', 'Mercredi et Samedi de 16h00 à 18h00', 'Wells Fargo Center', '1020 USD'),
(10, 'Spurs', '13', 'Mardi et Jeudi de 19h00 à 21h00', 'AT&T Center', '850 USD');

-- --------------------------------------------------------

--
-- Structure de la table `User`
--

CREATE TABLE `User` (
  `idUser` int(11) NOT NULL,
  `FirstName` varchar(200) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `idTeam` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `User`
--

INSERT INTO `User` (`idUser`, `FirstName`, `LastName`, `idTeam`) VALUES
(1, 'LeBron', 'James', NULL),
(2, 'Stephen', 'Curry', NULL),
(3, 'Kevin', 'Durant', NULL),
(4, 'Giannis', 'Antetokounmpo', NULL),
(5, 'Kawhi', 'Leonard', NULL),
(6, 'Luka', 'Doncic', NULL),
(7, 'Jayson', 'Tatum', NULL),
(8, 'Joel', 'Embiid', NULL),
(9, 'Damian', 'Lillard', NULL),
(10, 'Nikola', 'Jokic', NULL),
(11, 'Steve', 'Kerr', NULL),
(12, 'Erik', 'Spoelstra', NULL),
(13, 'Doc', 'Rivers', NULL),
(14, 'Gregg', 'Popovich', NULL),
(15, 'Nick', 'Nurse', NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`idAdmin`);

--
-- Index pour la table `Match`
--
ALTER TABLE `Match`
  ADD PRIMARY KEY (`idMatch`);

--
-- Index pour la table `Player`
--
ALTER TABLE `Player`
  ADD PRIMARY KEY (`idUser`),
  ADD KEY `fk_idStat_player` (`idStat`);

--
-- Index pour la table `Statistics`
--
ALTER TABLE `Statistics`
  ADD PRIMARY KEY (`idStat`);

--
-- Index pour la table `Team`
--
ALTER TABLE `Team`
  ADD PRIMARY KEY (`idTeam`);

--
-- Index pour la table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`idUser`),
  ADD KEY `fk_user_team` (`idTeam`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Match`
--
ALTER TABLE `Match`
  MODIFY `idMatch` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT pour la table `Statistics`
--
ALTER TABLE `Statistics`
  MODIFY `idStat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `Team`
--
ALTER TABLE `Team`
  MODIFY `idTeam` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `User`
--
ALTER TABLE `User`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Admin`
--
ALTER TABLE `Admin`
  ADD CONSTRAINT `fk_iduser_admin` FOREIGN KEY (`idAdmin`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `Player`
--
ALTER TABLE `Player`
  ADD CONSTRAINT `fk_idStat_player` FOREIGN KEY (`idStat`) REFERENCES `Statistics` (`idStat`),
  ADD CONSTRAINT `fk_idUser_player` FOREIGN KEY (`idUser`) REFERENCES `User` (`idUser`);

--
-- Contraintes pour la table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `fk_user_team` FOREIGN KEY (`idTeam`) REFERENCES `Team` (`idTeam`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
