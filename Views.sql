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