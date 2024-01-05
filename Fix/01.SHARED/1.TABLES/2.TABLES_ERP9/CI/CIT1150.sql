---- Create by Le Hoang on 01/10/2020
---- Updated by Tấn Tài on 17/10/2020
---- Updated by Đình Ly on 26/01/2021
---- Danh mục Nguồn lực

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1150]') AND TYPE IN (N'U'))
BEGIN

CREATE TABLE [dbo].[CIT1150]
(
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[MachineName] [nvarchar](250) NULL,
	[MachineNameE] [nvarchar](250) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[Model] [nvarchar](250) NULL,
	[Year] [int] NULL,
	[StartDate] [datetime] NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL DEFAULT (0),
	[CreateDate] [datetime] NULL DEFAULT GETDATE(),
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL DEFAULT GETDATE(),
	[LastModifyUserID] [nvarchar](50) NULL,

CONSTRAINT [PK_CIT1150] PRIMARY KEY NONCLUSTERED (
	[DivisionID] ASC,
	[MachineID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY]

END

---- Modified by Đình Ly on 26/01/2021: Thêm cột cho danh mục Nguồn lực.
---- Cột đơn vị tính
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'IsCommon')
	BEGIN
	ALTER TABLE CIT1150 ADD IsCommon TINYINT NOT NULL DEFAULT (0)
	END
END
---- Cột đơn vị tính
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'UnitID')
	BEGIN
	ALTER TABLE CIT1150 ADD UnitID VARCHAR(50) NULL
	END
END
---- Cột loại nguồn lực
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'ResourceTypeID')
	BEGIN
	ALTER TABLE CIT1150 ADD ResourceTypeID VARCHAR(50) NULL
	END
END
---- Cột thời gian hiệu suất
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'Efficiency')
	BEGIN
	ALTER TABLE CIT1150 ADD Efficiency DECIMAL(28) NULL
	END
END
---- Cột thời gian xếp hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'LinedUpTime')
	BEGIN
	ALTER TABLE CIT1150 ADD LinedUpTime DECIMAL(28) NULL
	END
END
---- Cột thời gian thiết lập
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'SettingTime')
	BEGIN
	ALTER TABLE CIT1150 ADD SettingTime DECIMAL(28) NULL
	END
END
---- Cột thời gian chờ
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'WaittingTime')
	BEGIN
	ALTER TABLE CIT1150 ADD WaittingTime DECIMAL(28) NULL
	END
END
---- Cột thời gian di chuyển
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'TransferTime')
	BEGIN
	ALTER TABLE CIT1150 ADD TransferTime DECIMAL(28) NULL
	END
END
---- Cột thời gian tối đa
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'MaxTime')
	BEGIN
	ALTER TABLE CIT1150 ADD MaxTime DECIMAL(28) NULL
	END
END
---- Cột thời gian tối thiểu
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'MinTime')
	BEGIN
	ALTER TABLE CIT1150 ADD MinTime DECIMAL(28) NULL
	END
END
---- Cột công suất/Đơn vị tính
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'GoldLimit')
	BEGIN
	ALTER TABLE CIT1150 ADD GoldLimit DECIMAL(28) NULL
	END
	ELSE
	BEGIN
		ALTER TABLE CIT1150 ALTER COLUMN GoldLimit DECIMAL(28,8) NULL
	END
END
---- Cột thời gian định mức
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'TimeLimit')
	BEGIN
	ALTER TABLE CIT1150 ADD TimeLimit DECIMAL(28) NULL
	END
END
---- Cột số lượng người đảm nhận máy
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'WorkersLimit')
	BEGIN
	ALTER TABLE CIT1150 ADD WorkersLimit DECIMAL(28) NULL
	END
END

---- cập nhật cột Year từ số thành chuỗi
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1150' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1150' AND col.name = 'Year')
	BEGIN
	ALTER TABLE CIT1150 ALTER COLUMN Year NVARCHAR(100) NULL
	END
END
