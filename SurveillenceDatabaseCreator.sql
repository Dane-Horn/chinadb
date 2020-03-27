--REMOVE DB IF IT EXISTS
USE master
ALTER DATABASE SurveillenceDB set single_user WITH rollback immediate
IF EXISTS(select * from sys.databases where name='SurveillenceDB')
DROP DATABASE SurveillenceDB

CREATE DATABASE SurveillenceDB;
GO

USE SurveillenceDB;
GO
----------------------------------

--PROVINCES TABLE
CREATE TABLE [dbo].[Districts](
    [districtId] int IDENTITY(1,1) NOT NULL,
	[districtName] varchar(100) NOT NULL,
	[size] float NOT NULL,
    [population] int DEFAULT 0,
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
	[lastMaintenceDate] datetime NULL,
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
	[addressLine1] varchar(200) NULL,
	[addressLine2] varchar(200) NULL,
	[addressLine3] varchar(200) NULL,
	[score] float NULL
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
	[citizenId] bigint NOT NULL,
	[actionId] int NOT NULL,
	[districtId] int NOT NULL,
	[cameraId] int NOT NULL,
	[accuracy] float NOT NULL,
	[occurenceTime] dateTime NOT NULL
);
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
;

GO


--ACTION LOGS FOREIGN KEYS
ALTER TABLE [dbo].ActionsLog
   ADD CONSTRAINT FK_actionLog_districtId FOREIGN KEY (districtId)
      REFERENCES Districts (districtId),
	  CONSTRAINT FK_actionLog_citizenId FOREIGN KEY (citizenId)
      REFERENCES Citizens (citizenId),
	  CONSTRAINT FK_actionLog_actionId FOREIGN KEY (actionId)
      REFERENCES Actions (actionId),
	  CONSTRAINT FK_actionLog_cameraId FOREIGN KEY (cameraId)
      REFERENCES Cameras (cameraId)
;
GO

--MOCK PROVINCE DATA
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Rohun',1254)
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Arcadia', 20909)
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Senestra', 743)
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Slum Town', 201)
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Fictional City Name', 1291)
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Definitely Not China', 83832)
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Haven', 2029)
INSERT [dbo].[Districts] ([districtName], [size]) VALUES (N'Slimp', 2099)
GO

--MOCK CAMERA DATA
INSERT [dbo].[Cameras] ([districtId], [lastMaintenceDate], [latitude],[longitude]) VALUES (3, convert(datetime,'21-02-12 6:10:00 PM',5), 32.5, 32.5)
INSERT [dbo].[Cameras] ([districtId], [lastMaintenceDate], [latitude], [longitude]) VALUES (3, convert(datetime,'21-02-12 6:10:00 PM',5), 32.6, 32.7)
GO

--MOCK OCCUPATION DATA
INSERT [dbo].[Occupations] ([occupationName]
	,[occupationDescription]
	,[importance]) VALUES ('Software Developer', 'Develops programs for the great state of Jumpong', 10)

GO

--MOCK PERSON DATA
INSERT [dbo].[Citizens]([citizenId],
	[firstName],
	[lastName],
	[dateOfBirth],
	[gender],
	[districtId],
	[occupationId],
	[addressLine1],
	[addressLine2],
	[addressLine3],
	[score]) 
	VALUES 
	(8928282818, 'Keanu', 'Teixeira', '1996-07-09', 'male', 3, 1, '12', '6th Street', 'Bloom', 500)
GO

--MOCK ACTION DATA
INSERT [dbo].[Actions]([actionName], [actionDescription], [score]) VALUES ('Murder', 'Straight up wiped a soul', 100)
GO

--MOCK ACTION LOG DATA 
INSERT [dbo].[ActionsLog](citizenId, actionId, districtId, cameraId, accuracy, occurenceTime) VALUES (8928282818, 1, 3, 1, 98.3, CURRENT_TIMESTAMP)
GO