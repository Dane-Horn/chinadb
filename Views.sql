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