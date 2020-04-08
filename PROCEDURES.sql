USE SurveillenceDB
GO
--################################################ Insert Citizen
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

--################################################ Insert ActionsLog Entry
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

--################################################ Update Citizen Mark
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

--################################################  Insert Camera
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

--################################################ Update Camera Maintenance Date
DROP PROCEDURE [dbo].usp_updateCameraMaintenance;  
GO

CREATE PROCEDURE [dbo].usp_updateCameraMaintenance
@pCameraID int
AS
UPDATE Cameras
SET Cameras.lastMaintenanceDate = GETDATE()
WHERE Cameras.cameraId = @pCameraID
GO

--################################################ Delete Old ActionsLog Entries
DROP PROCEDURE [dbo].usp_deleteOldActionsLogs;  
GO

CREATE PROCEDURE [dbo].usp_deleteOldActionsLogs
@pCutoffDate date
AS

IF(@pCutoffDate IS NULL)
BEGIN
	set @pCutoffDate = DateAdd(yy, -5, GetDate())
END

DELETE FROM ActionsLog
WHERE ActionsLog.occurenceTime < @pCutoffDate
GO

--############################################### Insert occupation
DROP PROCEDURE [dbo].usp_insertOccupation
GO

CREATE PROCEDURE [dbo].usp_insertOccupation
@pOccupationName varchar(100),
@pOccupationDescription varchar(500),
@pImportance int
AS
INSERT INTO dbo.Occupations(occupationName, occupationDescription, importance)
VALUES (@pOccupationName, @pOccupationDescription, @pImportance)
GO

--############################################## Insert Action
DROP PROCEDURE dbo.usp_insertAction
GO

CREATE PROCEDURE dbo.usp_insertAction
@pActionName varchar(100),
@pActionDescription varchar(500),
@pScore int
AS
INSERT INTO dbo.Actions(actionName, actionDescription, score)
VALUES (@pActionName, @pActionDescription, @pScore)
GO

--############################################## Insert District
DROP PROCEDURE dbo.usp_insertDistrict
GO

CREATE PROCEDURE dbo.usp_insertDistrict
@pDistrictName varchar(100),
@pSize float
AS
INSERT INTO dbo.Districts(districtName, size)
VALUES (@pDistrictName, @pSize)
GO

--############################################# Insert Markers
DROP PROCEDURE dbo.usp_insertMarker
GO

CREATE PROCEDURE dbo.usp_InsertMarker
@pDescription varchar(100),
@pImportance int
AS 
INSERT INTO dbo.Markers(markerDescription, importance)
VALUES(@pDescription, @pImportance)
GO

--########################################### Update Citizen Address
DROP PROCEDURE dbo.usp_updateCitizenAddress
GO


CREATE PROCEDURE dbo.usp_updateCitizenAddress
@pCitizenID bigint,
@pAddressLine1 varchar(200) = NULL,
@pAddressLine2 varchar(200) = NULL
AS
IF @pAddressLine1 IS NOT NULL
BEGIN
	UPDATE dbo.Citizens
	SET addressLine1 = @pAddressLine1
	WHERE citizenId = @pCitizenID
END
IF @pAddressLine2 IS NOT NULL
BEGIN
	UPDATE dbo.Citizens
	SET addressLine2 = @pAddressLine2
	WHERE citizenId = @pCitizenID
END
GO

--######################################### Delete Action
DROP PROCEDURE dbo.usp_deleteAction
GO

CREATE PROCEDURE dbo.usp_deleteAction
@pActionId int
AS
DELETE FROM dbo.Actions
WHERE actionId = @pActionId
GO