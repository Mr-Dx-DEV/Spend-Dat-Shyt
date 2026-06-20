-- Add the "sisters" job so only players with this job can craft BBL Shots.
-- Run this once in your ESX database (same DB that has your `jobs` and `job_grades` tables).

INSERT INTO `jobs` (`name`, `label`) VALUES ('sisters', 'Sisters')
ON DUPLICATE KEY UPDATE `label` = 'Sisters';

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`)
VALUES ('sisters', 0, 'sister', 'Sister', 0, '{}', '{}');

-- Give a player the job (replace IDENTIFIER with the player's identifier, e.g. license:xxx or steam:xxx):
-- UPDATE users SET job = 'sisters', job_grade = 0 WHERE identifier = 'IDENTIFIER';
