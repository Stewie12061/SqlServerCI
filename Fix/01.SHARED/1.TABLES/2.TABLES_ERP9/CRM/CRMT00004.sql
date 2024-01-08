---- Create by Trà Giang on 05/12/2019
---- Thiết lập tính hao hụt

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT00004]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT00004]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [Condition1] NVARCHAR(Max) NULL,
  [Condition2] NVARCHAR(Max) NULL,
  [Orders] int NULL
CONSTRAINT [PK_CRMT00004] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
---- Modified by Đình Ly on 16/01/2021: Delete column không sử dụng.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Min')
	ALTER TABLE CRMT00004 DROP COLUMN Min
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Max')
	ALTER TABLE CRMT00004 DROP COLUMN Max
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'PaperMin')
	ALTER TABLE CRMT00004 DROP COLUMN PaperMin
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'PaperMax')
	ALTER TABLE CRMT00004 DROP COLUMN PaperMax
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Add1000')
	ALTER TABLE CRMT00004 DROP COLUMN Add1000
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'SidePrint')
	ALTER TABLE CRMT00004 DROP COLUMN SidePrint
END

---- Modified by Đình Ly on 16/01/2021: Bổ sung cột thiệt lập hao hụt Mai Thư.
-- Loại giấy
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'PaperTypeID')
    ALTER TABLE CRMT00004 ADD PaperTypeID NVARCHAR(50) NULL
END

-- Công đoạn
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'PhaseID')
    ALTER TABLE CRMT00004 ADD PhaseID NVARCHAR(50) NULL
END

-- Loại điều kiện
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'ConditionType')
    ALTER TABLE CRMT00004 ADD ConditionType NVARCHAR(50) NULL
END

-- Điều kiện 1
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Condition1')
    ALTER TABLE CRMT00004 ADD Condition1 NVARCHAR(250) NULL
END

-- Điều kiện 2
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Condition2')
    ALTER TABLE CRMT00004 ADD Condition2 NVARCHAR(250) NULL
END

-- Điều kiện 3
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Condition3')
    ALTER TABLE CRMT00004 ADD Condition3 NVARCHAR(250) NULL
END

-- Điều kiện 4
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Condition4')
    ALTER TABLE CRMT00004 ADD Condition4 NVARCHAR(250) NULL
END

-- Điều kiện 5
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Condition5')
    ALTER TABLE CRMT00004 ADD Condition5 NVARCHAR(250) NULL
END

-- Điều kiện 6
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Condition6')
    ALTER TABLE CRMT00004 ADD Condition6 NVARCHAR(250) NULL
END

-- Hệ số
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Coefficient')
    ALTER TABLE CRMT00004 ADD Coefficient DECIMAL(28,8) NULL
END

-- Phần trăm hao hụt
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'PercentLoss')
    ALTER TABLE CRMT00004 ADD PercentLoss NVARCHAR(MAX) NULL
END

-- Số lượng
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT00004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT00004' AND col.name = 'Quantity')
    ALTER TABLE CRMT00004 ADD Quantity NVARCHAR(MAX) NULL
END