CREATE OR ALTER VIEW vPopulationPerDistrict AS
SELECT a.districtName, COUNT(b.citizenId) as population, (COUNT(b.citizenId) / a.size) as popDensity
FROM Districts a, Citizens b
WHERE a.districtId = b.districtId
GROUP BY  a.districtName, a.size
GO

CREATE OR ALTER VIEW vScorePerDistrict AS
select d.districtName, SUM(c.score) as score from dbo.Districts d
inner join dbo.Citizens c
on d.districtId = c.districtId
GROUP BY d.districtName
GO

create or alter view vScorePerOccupation AS
select o.occupationName as 'Occupation', SUM(c.score) as 'Total score' from dbo.Occupations o
inner join dbo.Citizens c
on c.occupationId = o.occupationId
group by o.occupationName
GO

create or alter view vActionsPerOccupation AS
select o.occupationName as 'Occupation', COUNT(al.citizenId) as 'Total score' from dbo.Occupations o
inner join dbo.Citizens c
on c.occupationId = o.occupationId
inner join dbo.ActionsLog al
on al.citizenId = c.citizenId
group by o.occupationName
GO

CREATE OR ALTER VIEW vMostActionsPerCamera AS
SELECT a.cameraID, a.actionID, act.actionName, Count(a.actionID) Occurences
FROM ActionsLog a, Actions act
WHERE a.actionID = act.actionID
GROUP BY a.cameraID, a.actionID, act.actionName, a.actionID
HAVING Count(a.actionID) >= ALL (
		SELECT COUNT(a1.actionID) Occ
		FROM ActionsLog a1, Actions act1
		WHERE a1.actionID = act1.actionID AND a1.cameraID = a.cameraID
		GROUP BY a1.cameraID, a1.actionID, act1.actionName
	)
GO

CREATE OR ALTER VIEW vCitizensActions AS
SELECT al.citizenId, c.firstName, c.lastName, o.occupationName AS 'occupation' , a.actionName AS 'action', a.score, d.districtName AS 'actionDistrict', al.occurenceTime as 'timestamp' 
FROM dbo.ActionsLog al
inner join dbo.Citizens c
ON al.citizenId = c.citizenId
inner join dbo.Actions a
ON al.actionId = a.actionId
inner join dbo.Occupations o
ON c.occupationId = o.occupationId
inner join dbo.Districts d
ON c.districtId = d.districtId
GO

CREATE or ALTER VIEW vGendersPerOccupation AS
SELECT o.occupationName AS 'Occupation', SUM(CASE WHEN c.gender = 'male' THEN 1 ELSE 0 END) as 'Males', SUM(CASE WHEN c.gender = 'female' THEN 1 ELSE 0 END) AS 'Females' FROM dbo.Occupations o
inner join dbo.Citizens c
ON c.occupationId = o.occupationId
GROUP BY o.occupationName
GO

CREATE OR ALTER VIEW vScorePerDistrict AS
SELECT d.districtId, d.districtName, dbo.fCalculateDistrictScore(d.districtId) as Score
from Districts d
GO
