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

--MOCK DISTRICT DATA
INSERT INTO [dbo].[Districts] (districtName, size)
    VALUES
        ('Wellwick', 6243.95),
        ('Riverburn', 3731.52),
        ('Eastwald', 2694.73),
        ('Newby', 1178.46),
        ('Raymarsh', 4541.0),
        ('Raymere', 5195.6),
        ('Newcoast', 6895.53),
        ('Coldmoor', 1679.15),
        ('Goldcrest', 6680.36),
        ('Grasslyn', 2495.93),
        ('Falconedge', 7325.21),
        ('Mallowwood', 778.24),
        ('Newmill', 3159.13),
        ('Mormead', 5844.99),
        ('Linville', 5082.45)
GO

--MOCK CAMERA DATA
INSERT [dbo].[Cameras] ([districtId], [lastMaintenceDate], [latitude],[longitude]) VALUES (3, convert(datetime,'21-02-12 6:10:00 PM',5), 32.5, 32.5)
INSERT [dbo].[Cameras] ([districtId], [lastMaintenceDate], [latitude], [longitude]) VALUES (3, convert(datetime,'21-02-12 6:10:00 PM',5), 32.6, 32.7)
GO

--MOCK OCCUPATION DATA
INSERT INTO [dbo].[Occupations] (importance, occupationName, occupationDescription)
    VALUES
        (4, 'Health physicist', 'Television fast number road soon represent it any product interest.'),
        (-5, 'Dealer', 'Stock produce owner friend them city.'),
        (2, 'Horticulturist, commercial', 'Build happen probably attack together blood arrive anyone prevent suggest argue.'),
        (6, 'Surveyor, planning and development', 'Once degree red play discussion nearly on car stock race.'),
        (6, 'Quantity surveyor', 'Necessary store girl professor five recently necessary middle arrive.'),
        (-6, 'Banker', 'Drop front area leader class financial every system might artist away way.'),
        (-4, 'Water quality scientist', 'Operation thousand town experience child send fast meet dinner.'),
        (5, 'Armed forces logistics/support/administrative officer', 'Skin require serve son three interest city number.'),
        (7, 'Research scientist (maths)', 'Everyone after open officer yourself ahead research degree market.'),
        (8, 'Environmental manager', 'Person two you prepare few until.'),
        (4, 'Accountant, chartered management', 'Center book time write of leg capital challenge item beat why.'),
        (-5, 'Equities trader', 'Already Democrat beyond stuff never already impact expect worry citizen.'),
        (4, 'Sales professional, IT', 'Entire against weight more poor exactly.'),
        (6, 'Runner, broadcasting/film/video', 'Management ahead ok next his your learn measure increase reason camera.'),
        (1, 'Financial controller', 'Movie past tough real pick century see fight clear clearly consider.'),
        (10, 'Engineer, aeronautical', 'Figure affect drop off knowledge newspaper walk film ok.'),
        (11, 'Designer, furniture', 'Expect great across law apply night chair.'),
        (-9, 'Nurse, learning disability', 'Pressure who a parent wind it safe her ready food official space.'),
        (-4, 'Science writer', 'Price institution film worry fire require with eye black.'),
        (-10, 'Accountant, chartered certified', 'Attention power will meet attack lead economy attorney series positive capital history allow.'),
        (7, 'Therapist, sports', 'Central sell beat yard enjoy appear whose employee produce beyond.'),
        (-3, 'Firefighter', 'Country old idea determine with positive issue level other enough teacher so across.'),
        (8, 'Armed forces operational officer', 'Fine American decision themselves available machine.'),
        (-8, 'Chartered accountant', 'Build individual travel rise to blue hundred when a wear fish if rest.'),
        (1, 'Teacher, music', 'Partner clearly pass theory maintain read tree industry unit run piece.'),
        (1, 'Housing manager/officer', 'Heart way development can speech help adult these activity before another get.'),
        (1, 'Television production assistant', 'Character keep author let example special.'),
        (7, 'Chief of Staff', 'Culture build check minute third relate mother piece third modern use.'),
        (2, 'Jewellery designer', 'Site sound although perform stand individual today travel anyone practice detail computer.'),
        (3, 'Mudlogger', 'Late simply would blue include officer discover family operation produce board.'),
        (-5, 'Counsellor', 'But card by pass hand different.'),
        (-7, 'Homeopath', 'Outside specific want white chance sound able treat actually.'),
        (-6, 'Consulting civil engineer', 'Risk smile poor another force east team we.'),
        (0, 'Surveyor, land/geomatics', 'He rise left population avoid support design go quality another season.'),
        (2, 'Amenity horticulturist', 'Case somebody agent subject them film step blue future yes.'),
        (0, 'Pharmacologist', 'Sea reality deal perform deep fine among.'),
        (-4, 'Futures trader', 'Alone common picture culture rate itself you standard.'),
        (-6, 'Financial risk analyst', 'Best national pull authority surface performance realize line design during both hundred.'),
        (-1, 'Forensic scientist', 'Cultural million nation past firm newspaper participant.'),
        (9, 'Lawyer', 'Site pick total budget last discussion if find send writer run poor decade.'),
        (-10, 'Engineer, communications', 'Kind easy how a official Mr agency of forget support employee.'),
        (2, 'Oceanographer', 'Industry international indeed traditional three lose boy fine note stage explain agency first.'),
        (-8, 'Freight forwarder', 'Town economic reality somebody agent cut wind hair record perhaps.'),
        (-4, 'Manufacturing engineer', 'Whom then notice doctor form there fund former along.'),
        (5, 'Product designer', 'Hair issue mention west mean despite why cultural however table close.'),
        (0, 'Commercial/residential surveyor', 'Live business leg budget Republican open hit compare magazine performance.'),
        (-3, 'Trade union research officer', 'Run participant summer week but short.'),
        (8, 'Haematologist', 'Yet big drop tax may about stay field window writer lay fly themselves.'),
        (1, 'Environmental health practitioner', 'Wait stay including stay marriage sort kid cultural indeed agree.'),
        (6, 'Logistics and distribution manager', 'Open sign radio animal crime ready concern fear glass pattern or security fight.'),
        (11, 'Press sub', 'Trip individual fact only hope big cost.'),
        (-4, 'Glass blower/designer', 'Another statement society Republican full but.'),
        (-6, 'Civil Service fast streamer', 'Hour office technology know church get run whatever image research.'),
        (-8, 'Primary school teacher', 'Teacher exactly shake push house baby record prepare until item use body scene.'),
        (-1, 'Hydrographic surveyor', 'We project need international leave fire result light western.'),
        (-10, 'Arts administrator', 'Now buy into test have development century early.'),
        (6, 'Mental health nurse', 'Close truth listen claim of final know.'),
        (-3, 'Therapist, occupational', 'Guy half account employee approach together produce education short recent.'),
        (-3, 'Technical brewer', 'Last way room activity Mr check cause she.'),
        (-1, 'English as a second language teacher', 'Agency ahead issue do much conference in method sea court woman chance.'),
        (4, 'Civil engineer, consulting', 'Natural board article sea save believe do family probably art son hundred none.'),
        (2, 'Administrator', 'Doctor social task learn collection national pay writer two black investment.'),
        (1, 'Surveyor, insurance', 'Six deep identify all thing minute agree will.'),
        (-4, 'Sports development officer', 'Food admit need budget think hand knowledge.'),
        (-7, 'Surveyor, minerals', 'College chair attack leg physical pick collection.'),
        (2, 'Quarry manager', 'Bill line less simply authority resource.'),
        (-7, 'Psychiatric nurse', 'Fund social deal type buy end through high drive.'),
        (11, 'Chemist, analytical', 'Southern within town public big marriage only.'),
        (-5, 'Conservation officer, historic buildings', 'Analysis pull exist great news some sure very doctor senior measure it usually.'),
        (4, 'Accountant, chartered public finance', 'System spend present sure everybody writer leader training with discussion nature up unit.'),
        (-5, 'Hotel manager', 'Senior finally my foot sport face.'),
        (7, 'Trading standards officer', 'Foreign college none during somebody stage matter test she impact.'),
        (9, 'Actor', 'Thought his player care character run maybe night speech history.'),
        (-5, 'Tour manager', 'Around on team family positive actually central.'),
        (0, 'Pathologist', 'Person north everything often all discussion impact thousand subject model in address night.'),
        (-4, 'Sports therapist', 'Its eight site whole direction seven memory base party.'),
        (-1, 'IT trainer', 'She five interview pay enjoy later.'),
        (1, 'Engineer, petroleum', 'Play rather fine along open act the statement detail require.'),
        (6, 'Management consultant', 'Life its rule help east step imagine.'),
        (-9, 'Claims inspector/assessor', 'Traditional visit democratic himself might town news.'),
        (-10, 'Loss adjuster, chartered', 'Keep new manage theory respond pattern.'),
        (10, 'Insurance claims handler', 'Effort describe station significant protect you consider two class.'),
        (11, 'Ergonomist', 'Approach even music tree charge sense own treatment its be spring.'),
        (9, 'Geneticist, molecular', 'Be factor make fish similar no man science key former hand.'),
        (-1, 'Designer, multimedia', 'Party across stage entire though own section so return report onto boy end.'),
        (4, 'Drilling engineer', 'Western your medical glass simply fear prepare without oil type apply television able.'),
        (11, 'Designer, television/film set', 'With new trade shake during teacher ever trade international down.'),
        (1, 'Aid worker', 'Next result save industry set pick end that past word.'),
        (6, 'Site engineer', 'Say general stock like care poor young parent catch yet why policy.'),
        (6, 'Pharmacist, community', 'Along deep generation occur quality less expert start goal fast.'),
        (1, 'Nurse, mental health', 'Themselves week start media just glass magazine truth close.'),
        (-7, 'Advertising account executive', 'Modern entire responsibility would bar laugh.'),
        (3, 'Secondary school teacher', 'Box boy current me including marriage rest day morning quality.'),
        (4, 'Public relations officer', 'Show reality yourself dog should senior.'),
        (-4, 'Editor, commissioning', 'Civil important store benefit college price.'),
        (5, 'Architectural technologist', 'Allow action way possible but easy put recently other card measure.'),
        (6, 'Retail merchandiser', 'Result majority audience option country country.'),
        (1, 'Recycling officer', 'Mouth per may mission state change red owner determine good why evidence approach.'),
        (-5, 'Engineer, automotive', 'Various condition maybe adult decide strategy education degree wish television much eye set.'),
        (0, 'Scientist, research (physical sciences)', 'Now mouth stay blue executive writer even black.')

GO

--MOCK PERSON DATA
INSERT INTO [dbo].[Citizens] (citizenId, firstName, lastName, dateOfBirth, gender, districtId, occupationId, addressLine1, addressLine2)
    VALUES
        (1519059975720, 'Amanda', 'Dunn', '1999-07-05', 'male', 4, 91, '01503', 'Barbara Mountains Apt. 860'),
        (3091774157548, 'Tristan', 'Jimenez', '1983-12-19', 'female', 14, 79, '92870', 'Powell Mountains Suite 239'),
        (6105928435090, 'Maria', 'Reed', '1978-06-30', 'male', 8, 98, '45464', 'Chapman Route Suite 761'),
        (3860281599910, 'Kristy', 'Ward', '1985-06-27', 'female', 8, 77, '23792', 'Barbara Causeway Apt. 492'),
        (7731491866877, 'Micheal', 'Hansen', '2003-01-09', 'male', 7, 44, '43516', 'Santos Landing Apt. 926'),
        (7378087263845, 'Nancy', 'Lee', '2019-06-14', 'male', 8, 21, '11930', 'Phillips Cliff Apt. 301'),
        (7727308487395, 'James', 'Quinn', '1973-10-28', 'female', 15, 23, '59009', 'Cardenas Plains Apt. 167'),
        (6011379470054, 'Jerry', 'Skinner', '2012-03-26', 'male', 13, 96, '84557', 'Lopez Hill Apt. 448'),
        (9278157916469, 'Lindsey', 'Parker', '2007-10-09', 'female', 4, 2, '72639', 'Hayes Expressway Apt. 044'),
        (1479333450285, 'Jasmine', 'Clark', '2012-07-17', 'male', 15, 29, '39914', 'Courtney LodgeSuite 204'), 
		(8928282818, 'Keanu', 'Teixeira', '1996-07-09', 'male', 3, 1, '12', '6th Street Bloom')
GO

--MOCK ACTION DATA
INSERT [dbo].[Actions]([actionName], [actionDescription], [score]) VALUES ('Murder', 'Straight up wiped a soul', 100)
GO

--MOCK ACTION LOG DATA 
INSERT [dbo].[ActionsLog](citizenId, actionId, districtId, cameraId, accuracy, occurenceTime) VALUES (8928282818, 1, 3, 1, 98.3, CURRENT_TIMESTAMP)
GO