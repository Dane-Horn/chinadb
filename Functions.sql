use master;
use SurveillenceDB;
GO

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
