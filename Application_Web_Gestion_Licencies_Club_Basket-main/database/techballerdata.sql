-- -----------------------------------------------------
-- Table `techballerdb`.`Match`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`Match` (`Championship`, `Stage`, `Score`, `Date`, `Place`, `Description`,`Image` ) VALUES 
('Tournoi Local', 'Finale', 52, '2024-04-20 15:00:00', 'Gymnase Mimoun', 'Finale du tournoi local opposant les Minimes Garçons et les Benjamins.', '/src/assets/img_matches/competition_intern.jpg'),
('Championnat Départemental', 'Demi-finale', 47, '2024-03-18 18:30:00', 'Jeu de Paume', 'Demi-finale départementale entre les Cadettes de Villepreux et de Fontenay Le Fleury.', '/src/assets/img_matches/competition_fontenay.jpg'),
('Championnat Régional', 'Phase de Poules', 61, '2024-05-05 16:00:00', 'Bourneton', 'Match de poules du championnat régional avec les Seniors Garçons de Villepreux et Rambouillet Sport.', '/src/assets/img_matches/competition_rambouillet.jpg'),
('Amical', 'Rencontre 1', 39, '2024-02-25 14:00:00', 'Mimoun', 'Match amical entre les Poussins 2e année et les Poussin 1er année.', '/src/assets/img_matches/competition_intern.jpg'),
('Tournoi Amical', 'Finale', 70, '2024-07-10 17:00:00', 'Jeu de Paume', 'Finale du tournoi amical avec les Seniors Filles de Villepreux en tête d’affiche contre le Chesnay Versailles.', '/src/assets/img_matches/competition_versailles.jpg'),
('Championnat National', 'Quarts de Finale', 56, '2024-06-15 19:00:00', 'Jeu de Paume', 'Quart de finale national des Cadets, affrontant l’équipe rivale Nanterre.', '/src/assets/img_matches/competition_nanterre.jpg'),
('Tournoi Interclub', '1er Tour', 62, '2024-05-25 15:30:00', 'Mimoun', 'Premier tour du tournoi interclub avec les Benjamins de Villepreux et de Fontenay Le Fleury.', '/src/assets/img_matches/competition_fontenay.jpg'),
('Championnat Local', 'Finale', 48, '2024-03-30 16:00:00', 'Jeu de Paume', 'Finale du championnat local entre les Benjamines de Villepreux et de Chesnay Versailles.', '/src/assets/img_matches/competition_versailles.jpg'),
('Tournoi d’Été', 'Match d’Ouverture', 58, '2024-08-01 18:00:00', 'Jeu de Paume', 'Match d’ouverture du tournoi d’été avec les Seniors Garçons de Villepreux et de Fontenay Le Fleury.', '/src/assets/img_matches/competition_fontenay.jpg'),
('Match Amical', 'Rencontre 3', 41, '2024-04-10 14:30:00', 'Mimoun', 'Match amicale entre les Détente et les Benjamines Garçons.', '/src/assets/img_matches/competition_intern.jpg'),
('Championnat Départemental', 'Finale', 67, '2024-03-20 19:00:00', 'Jeu de Paume', 'Finale du championnat départemental des Minimes Garçons de Villepreux et de Fontenay Le Fleury.', '/src/assets/img_matches/competition_fontenay.jpg'),
('Tournoi Interclub', 'Demi-finale', 55, '2024-05-27 17:00:00', 'Jeu de Paume', 'Demi-finale du tournoi interclub opposant les Seniors Filles de Villepreux à Rambouillet Sport.', '/src/assets/img_matches/competition_rambouillet.jpg');
-- -----------------------------------------------------
-- Table `techballerdb`.`Statistics`
-- -----------------------------------------------------
INSERT INTO `techballerdb`.`Statistics` 
(`Rebounds`, `Points`, `ThreePtsFieldGoalsMade`, `ThreePtsFieldGoalsAttempted`, `FreeThrowMade`, `FreeThrowAttempted`) 
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