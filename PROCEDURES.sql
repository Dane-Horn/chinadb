USE SurveillenceDB
GO

DROP PROCEDURE [dbo].usp_insertCitizen;  
GO

CREATE PROCEDURE [dbo].usp_insertCitizen
@pCitizenID bigint,
@pFirstName varchar(100),
@pLastName varchar(100),
@pDOB date,
@pGender varchar(25),
@pDistrictID int,
@pOccupationID int,
@pMarkerID int,
@pAddressLine1 varchar(200),
@pAddressLine2 varchar(200),
@pScore float
AS
INSERT INTO [dbo].Citizens (citizenId, firstName, lastName, dateOfBirth, gender, districtId, occupationId, markerId, addressLine1, addressLine2,score)
    VALUES (@pCitizenID,@pFirstName,@pLastName,@pDOB,@pGender,@pDistrictID,@pOccupationID,@pMarkerID,@pAddressLine1,@pAddressLine2,@pScore)
GO

DROP PROCEDURE [dbo].usp_AddActionToLog;  
GO  

CREATE PROCEDURE [dbo].usp_AddActionToLog  
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

DROP PROCEDURE [dbo].usp_MarkCitizen;  
GO  

CREATE PROCEDURE [dbo].usp_MarkCitizen  
    @citizenId bigint,
	@markId int
AS   
BEGIN
SET NOCOUNT ON;  
UPDATE [dbo].[Citizens] 
SET markerId = @markId
WHERE @citizenId = [Citizens].citizenId

END
GO

DROP PROCEDURE [dbo].usp_insertCamera;  
GO

CREATE PROCEDURE [dbo].usp_insertCamera
@pDistrictID int,
@pLatitude float,
@pLongitude float,
@pLastMaintenenceDate date
AS

IF(@pLastMaintenenceDate IS NULL)
BEGIN
set @pLastMaintenenceDate = GETDATE()
END

INSERT INTO [dbo].Cameras (districtId,latitude,longitude,lastMaintenanceDate)
    VALUES (@pDistrictID,@pLatitude,@pLongitude,@pLastMaintenenceDate)
GO


DROP PROCEDURE [dbo].usp_updateCameraMaintenance;  
GO

CREATE PROCEDURE [dbo].usp_updateCameraMaintenance
@pCameraID int
AS
UPDATE Cameras
SET Cameras.lastMaintenanceDate = GETDATE()
WHERE Cameras.cameraId = @pCameraID
GO