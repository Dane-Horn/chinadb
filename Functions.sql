use master;
use SurveillenceDB;
GO
--################################################ Most Actions between Dates
CREATE OR ALTER FUNCTION dbo.fMostActionsBetweenDates(
    @StartDate Date,
	@EndDate Date )
RETURNS TABLE
AS
RETURN (
	SELECT a.cameraID, a.actionID, act.actionName, Count(a.actionID) Occurences
	FROM ActionsLog a RIGHT JOIN Actions act
		on a.actionID = act.actionID
	WHERE a.occurenceTime between @StartDate 
				and @EndDate
	GROUP BY a.cameraID, a.actionID, act.actionName, a.actionID
	HAVING Count(a.actionID) >= ALL (
			SELECT COUNT(a1.actionID) Occ
			FROM ActionsLog a1 Right JOIN Actions act1
			on a1.actionID = act1.actionID AND a1.cameraID = a.cameraID
			where a1.occurenceTime between @StartDate 
				and @EndDate
			GROUP BY a1.cameraID, a1.actionID, act1.actionName
	)
)
GO

--################################################ Find Cameras needing Maintenance
create or alter function dbo.fCamerasToMaintain(
	@DistrictName varchar(100),
	@YearLimit int
)
returns table
as 
return (
	select c.cameraId, c.longitude, c.latitude, c.lastMaintenanceDate from Districts d
	inner join Cameras c
	on c.districtId = d.districtId
	where d.districtName = @DistrictName
	and DATEDIFF(year, c.lastMaintenanceDate, CURRENT_TIMESTAMP) > @YearLimit
)
GO

--################################################ Calculate District Score
create or alter function dbo.fCalculateDistrictScore(
	@districtId int
)
RETURNS int
AS
BEGIN
declare @citizenScore float

	select @citizenScore = sum(a.scored)
	from(
	SELECT c.score * m.importance * o.importance as scored
	from Citizens c 
		left join Markers m on c.markerId = m.markerId
		left join Occupations o on c.occupationId = o.occupationId
	where districtId = @districtId) a

RETURN @citizenScore
END
GO