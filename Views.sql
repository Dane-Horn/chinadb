CREATE OR ALTER VIEW vPopulationPerDistrict AS
SELECT [districtName], COUNT(b.citizenId) population
FROM Districts a, Citizens b
WHERE a.districtId = b.districtId
GROUP BY  a.districtName
GO

CREATE OR ALTER VIEW vScorePerDistrict AS
select d.districtName, SUM(c.score) as score from dbo.Districts d
inner join dbo.Citizens c
on d.districtId = c.districtId
GROUP BY d.districtName
GO

create or alter view vScorePerOccupation AS
select o.occupationName as 'Occupation', SUM(a.score) as 'Total score' from dbo.Occupations o
inner join dbo.Citizens c
on c.occupationId = o.occupationId
inner join dbo.ActionsLog al
on al.citizenId = c.citizenId
inner join dbo.Actions a
on al.actionId = a.actionId
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
