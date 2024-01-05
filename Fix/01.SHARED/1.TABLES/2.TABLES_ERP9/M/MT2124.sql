---- Create by Đức Tuyên
---- Bảng dữ liệu nghiệp vụ Định mức nhân công.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2124]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2124]
(
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NULL,
	[APK_2120] UNIQUEIDENTIFIER NULL,
	[DivisionID] VARCHAR(25) NOT NULL,
	[NodeTypeID] VARCHAR(50) NOT  NULL,
	[NodeID] VARCHAR(50) NOT NULL,
	[NodeName] NVARCHAR(250) NULL,
	[NodeParent] UNIQUEIDENTIFIER NULL,
	[NodeLevel] INT NULL,
	[NodeOrder] INT NULL,
	[RoutingID] VARCHAR(50) NULL,
	[PhaseID] VARCHAR(50) NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[Orders] INT NULL,
	[LaborID] VARCHAR(50)  NULL,
	[LaborName] NVARCHAR(50)  NULL,
	[LaborUnitID] DECIMAL(28) NULL,
	[TimeLimit] DECIMAL(28) NULL,
	[Description] NVARCHAR(500) NULL


CONSTRAINT [PK_MT2124] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------04/07/2023 - Đức Tuyên: Loại bỏ các cột NVL khỏi nhân công----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'NodeTypeID')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN NodeTypeID
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'NodeID')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN NodeID
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'NodeName')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN NodeName
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'NodeParent')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN NodeParent
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'NodeLevel')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN NodeLevel
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'NodeOrder')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN NodeOrder
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'RoutingID')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN RoutingID
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'APK_2120')
BEGIN
	ALTER TABLE MT2124 DROP COLUMN APK_2120
END
---------------04/07/2023 - Đức Tuyên: Loại bỏ các cột NVL khỏi nhân công----------------


IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2124' AND col.name = 'LaborUnitID')
BEGIN
	ALTER TABLE MT2124 ALTER COLUMN LaborUnitID VARCHAR(50) NULL
END

