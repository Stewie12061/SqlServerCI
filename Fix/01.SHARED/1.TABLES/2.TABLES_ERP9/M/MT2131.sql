---- Create by Đình Ly on 06/10/2020
---- Bảng dữ liệu chi tiết Nghiệp vụ quy trình sản xuất.

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2131]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[MT2131]
	(
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[APKMaster] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[PhaseID] VARCHAR(50) NOT NULL,
		[PhaseName] NVARCHAR(250) NOT NULL,
		[UnitID] VARCHAR(50) NOT NULL,
		[PhaseTime] DECIMAL(28) NULL,
		[PhaseOrder] INT NULL, 
		[PreviousOrders] VARCHAR(50) NULL,
		[NextOrders] VARCHAR(50) NULL,
		[ResourceID] VARCHAR(50) NULL,
		[ResourceName] NVARCHAR(250) NULL,
		[SettingTime] DECIMAL(28) NULL,
		[LinedUpTime] DECIMAL(28) NULL,
		[WaittingTime] DECIMAL(28) NULL,
		[TransferTime] DECIMAL(28) NULL,
		[MinTime] DECIMAL(28) NULL,
		[MaxTime] DECIMAL(28) NULL,
		[CreateUserID] VARCHAR(50) NULL,
		[CreateDate] DATETIME NULL,
		[LastModifyUserID] VARCHAR(50) NULL,
		[LastModifyDate] DATETIME NULL

    CONSTRAINT [PK_MT2131] PRIMARY KEY CLUSTERED ([APK])
		WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
 
---------------- 27/12/2020 - Đình Ly: Bổ sung cột UnitID ----------------

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2131' AND col.name = 'ResourceUnitID')
BEGIN
	ALTER TABLE MT2131 ADD ResourceUnitID VARCHAR(50) NULL
END

---------------- Đình Hòa - [21/06/2021] : Update kiểu dữ liệu ----------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2131' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2131' AND col.name='PhaseTime')
	
	ALTER TABLE MT2131 ALTER COLUMN PhaseTime DECIMAL(28,8) NULL
END
 
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2131' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2131' AND col.name='SettingTime')
	
	ALTER TABLE MT2131 ALTER COLUMN SettingTime DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2131' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2131' AND col.name='LinedUpTime')
	
	ALTER TABLE MT2131 ALTER COLUMN LinedUpTime DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2131' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2131' AND col.name='WaittingTime')
	
	ALTER TABLE MT2131 ALTER COLUMN WaittingTime DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2131' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='TransferTime' AND col.name='TransferTime')
	
	ALTER TABLE MT2131 ALTER COLUMN PhaseTime DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2131' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2131' AND col.name='MinTime')
	
	ALTER TABLE MT2131 ALTER COLUMN MinTime DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2131' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2131' AND col.name='MaxTime')
	
	ALTER TABLE MT2131 ALTER COLUMN MaxTime DECIMAL(28,8) NULL
END