--REMOVE DB IF IT EXISTS
USE master
ALTER DATABASE SurveillenceDB set single_user WITH rollback immediate
DROP DATABASE SurveillenceDB

CREATE DATABASE SurveillenceDB;
GO

USE SurveillenceDB;
GO
----------------------------------

--DISTRICTS TABLE
CREATE TABLE [dbo].[Districts](
    [districtId] int IDENTITY(1,1) NOT NULL,
	[districtName] varchar(100) NOT NULL,
	[size] float NOT NULL
);
GO

ALTER TABLE dbo.Districts
ADD CONSTRAINT [PK_districtId] PRIMARY KEY CLUSTERED ([districtId] ASC);
GO

--CAMERAS TABLE
CREATE TABLE [dbo].[Cameras](
	[cameraId] int IDENTITY(1,1) NOT NULL,
	[districtId] int NULL,
	[latitude] decimal(9,6) NULL,
	[longitude] decimal(9,6) NULL,
	[lastMaintenanceDate] datetime NULL,
);
GO

ALTER TABLE [dbo].[Cameras]
   ADD CONSTRAINT [PK_cameraId] PRIMARY KEY CLUSTERED ([cameraId] ASC);
;
GO


--CITIZENS TABLE
CREATE TABLE [dbo].[Citizens](
	[citizenId] bigint NOT NULL,
	[firstName] varchar(100) NOT NULL,
	[lastName] varchar(100) NOT NULL,
	[dateOfBirth] date NOT NULL,
	[gender] varchar(200) NOT NULL,
	[districtId] int NOT NULL,
	[occupationId] int NOT NULL,
	[markerId] int NOT NULL,
	[addressLine1] varchar(200) NULL,
	[addressLine2] varchar(200) NULL,
	[score] float NOT NULL DEFAULT 0.00
);
GO

ALTER TABLE [dbo].Citizens
ADD CONSTRAINT [PK_citizenId] PRIMARY KEY CLUSTERED ([citizenId] ASC)
;


--OCCUPATIONS TABLE
CREATE TABLE [dbo].[Occupations](
	[occupationId] int IDENTITY(1,1) NOT NULL,
	[occupationName] varchar(1000) NOT NULL,
	[occupationDescription] varchar(1000) NULL,
	[importance] float NOT NULL,
);
GO

ALTER TABLE dbo.Occupations
	ADD CONSTRAINT [PK_occupationId] PRIMARY KEY CLUSTERED ([occupationId] ASC);
GO

--MARKERS TABLE
CREATE TABLE [dbo].[Markers](
	[markerId] int IDENTITY(1,1) NOT NULL,
	[markerDescription] varchar(1000) NULL,
	[importance] float NOT NULL,
);
GO

ALTER TABLE dbo.Markers
	ADD CONSTRAINT [PK_markerId] PRIMARY KEY CLUSTERED ([markerId] ASC);
GO

--ACTIONS TABLE
CREATE TABLE [dbo].[Actions](
	[actionId] int IDENTITY(1,1) NOT NULL,
	[actionName] varchar(1000) NOT NULL,
	[actionDescription] varchar(1000) NULL,
	[score] float NOT NULL,
);
GO

ALTER TABLE dbo.Actions
	ADD CONSTRAINT [PK_actionId] PRIMARY KEY CLUSTERED ([actionId] ASC);
GO

--ACTIONS LOG TABLE
CREATE TABLE [dbo].[ActionsLog](
	[cameraLogId] bigint IDENTITY(1,1) NOT NULL,
	[citizenId] bigint NOT NULL,
	[actionId] int NOT NULL,
	[cameraId] int NOT NULL,
	[accuracy] float NOT NULL,
	[occurenceTime] dateTime NOT NULL
);
GO

ALTER TABLE dbo.ActionsLog
	ADD CONSTRAINT [PK_actionId] PRIMARY KEY CLUSTERED ([cameraLogId] ASC);
GO

--ADD FOREIGN KEYS--
--CAMERAS FOREIGN KEYS
ALTER TABLE [dbo].[Cameras]
   ADD CONSTRAINT FK_camera_districtId FOREIGN KEY (districtId)
      REFERENCES Districts (districtId)
;
GO

--CITIZENS FOREIGN KEYS
ALTER TABLE [dbo].Citizens
   ADD CONSTRAINT FK_citizen_districtId FOREIGN KEY (districtId)
      REFERENCES Districts (districtId)
	,CONSTRAINT FK_citizen_occupationId FOREIGN KEY (occupationId)
      REFERENCES Occupations (occupationId)
	,CONSTRAINT FK_citizen_markerId FOREIGN KEY (markerId)
      REFERENCES Markers (markerId)
;

GO


--ACTION LOGS FOREIGN KEYS
ALTER TABLE [dbo].ActionsLog
	  ADD CONSTRAINT FK_actionLog_citizenId FOREIGN KEY (citizenId)
      REFERENCES Citizens (citizenId),
	  CONSTRAINT FK_actionLog_actionId FOREIGN KEY (actionId)
      REFERENCES Actions (actionId),
	  CONSTRAINT FK_actionLog_cameraId FOREIGN KEY (cameraId)
      REFERENCES Cameras (cameraId)
;
GO




