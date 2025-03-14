ALTER TABLE techballerdb.Statistics
CHANGE COLUMN `3PtsFieldGoalsMade` ThreePtsFieldGoalsMade INT DEFAULT NULL;

ALTER TABLE techballerdb.Statistics
CHANGE COLUMN `3PtsFieldGoalsAttempted` ThreePtsFieldGoalsAttempted INT DEFAULT NULL;

-- Added the `idTeam` column in the `User` table
ALTER TABLE `techballerdb`.`User`
ADD COLUMN `idTeam` INT;

-- Creating the foreign key between `User.idTeam` and `Team.idTeam`
ALTER TABLE `techballerdb`.`User`
ADD CONSTRAINT `fk_user_team`
FOREIGN KEY (`idTeam`)
REFERENCES `techballerdb`.`Team`(`idTeam`);

-- Allow `NULL` for the `idTeam` column in the `User` table.
ALTER TABLE `techballerdb`.`User`
MODIFY `idTeam` INT NULL;


-- Updating users with an idTeam between 1 and 10
UPDATE `techballerdb`.`User`
SET `idTeam` = CASE `idUser`
    WHEN 1 THEN 1
    WHEN 2 THEN 2
    WHEN 3 THEN 3
    WHEN 4 THEN 4
    WHEN 5 THEN 5
    WHEN 6 THEN 6
    WHEN 7 THEN 7
    WHEN 8 THEN 8
    WHEN 9 THEN 9
    WHEN 10 THEN 10
    WHEN 11 THEN 1
    WHEN 12 THEN 2
    WHEN 13 THEN 3
    WHEN 14 THEN 4
    WHEN 15 THEN 5
    WHEN 16 THEN 6
END
WHERE `idUser` BETWEEN 1 AND 16;
