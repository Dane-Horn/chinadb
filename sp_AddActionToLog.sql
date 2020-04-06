use master;
use SurveillenceDB;
GO
DROP PROCEDURE [dbo].AddActionToLog;  
GO  

CREATE PROCEDURE [dbo].AddActionToLog  
    @citizenId bigint,   
    @actionId int,
	@cameraId int,
	@accuracy float,
	@occurenceTime dateTime
AS   
BEGIN
SET NOCOUNT ON;  
INSERT INTO [dbo].[ActionsLog] (citizenId, actionId, cameraId, accuracy, occurenceTime)
VALUES (@citizenId, @actionId, @cameraId, @accuracy, @occurenceTime)

DECLARE @actionScore float;

SELECT @actionScore = score
FROM [dbo].Actions
WHERE @actionId = actionId

UPDATE [dbo].[Citizens]
SET score = score + @actionScore
WHERE @citizenId = [Citizens].citizenId

END
GO

EXEC [dbo].AddActionToLog @citizenId= 1009811972509, @actionId = 2, @cameraId = 2, @accuracy = 98, @occurenceTime = '2016-12-21 00:00:00.000';
GO