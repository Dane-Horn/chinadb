CREATE OR ALTER VIEW vPopulationPerDistrict AS
SELECT [districtName], COUNT(b.citizenId) population
FROM Districts a, Citizens b
WHERE a.districtId = b.districtId
GROUP BY  a.districtName
GO