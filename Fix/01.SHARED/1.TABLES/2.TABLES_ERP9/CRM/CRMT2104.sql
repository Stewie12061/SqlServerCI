---- Create by Nguyễn Tấn Lộc on 12/22/2020 9:57:45 AM
---- Lưới detail yêu cầu khách hàng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2104]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2104]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(250) NULL,
  [APKMaster] VARCHAR(250) NULL,
  [PhaseID] VARCHAR(50) NULL,
  [DisplayName] NVARCHAR(MAX) NULL,
  [KindSuppliers] NVARCHAR(250) NULL,
  [Size] DECIMAL(28,8) NULL,
  [Cut] DECIMAL(28,8) NULL,
  [Child] DECIMAL(28,8) NULL,
  [PrintTypeID] VARCHAR(50) NULL,
  [RunPaperID] VARCHAR(50) NULL,
  [RunWavePaper] VARCHAR(50) NULL,
  [MoldID] VARCHAR(50) NULL,
  [MoldStatusID] VARCHAR(50) NULL,
  [MoldDate] DATETIME NULL,
  [MaterialID] NVARCHAR(250) NULL,
  [Quantity] DECIMAL(28,8) NULL,
  [UnitSizeID] VARCHAR(50) NULL,
  [TranMonth] INT NULL,
  [Tranyear] INT NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_CRMT2104] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 29/12/2020 - Tấn Lộc: Bổ sung cột --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'UnitID')
BEGIN
	ALTER TABLE CRMT2104 ADD UnitID NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'Gsm')
BEGIN
	ALTER TABLE CRMT2104 ADD Gsm DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'Sheets')
BEGIN
	ALTER TABLE CRMT2104 ADD Sheets DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'Ram')
BEGIN
	ALTER TABLE CRMT2104 ADD Ram DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'Kg')
BEGIN
	ALTER TABLE CRMT2104 ADD Kg DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'M2')
BEGIN
	ALTER TABLE CRMT2104 ADD M2 DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'PhaseOrder')
BEGIN
	ALTER TABLE CRMT2104 ADD PhaseOrder INT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'NodeTypeID')
BEGIN
	ALTER TABLE CRMT2104 ADD NodeTypeID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'NodeParent')
BEGIN
	ALTER TABLE CRMT2104 ADD NodeParent VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'APKNodeParent')
BEGIN
	ALTER TABLE CRMT2104 ADD APKNodeParent VARCHAR(250) NULL
END

-- 00/07/2021 - [Đình Ly] - Begin Add
-- Bổ sung cột Notes (Ghi chú) cho chi tiết Yêu cầu khách hàng.
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'Notes')
BEGIN
	ALTER TABLE CRMT2104 ADD Notes NVARCHAR(MAX) NULL
END

-- Bổ sung cột GluingTypeID (Nhóm dán) cho chi tiết Yêu cầu khách hàng.
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2104' AND col.name = 'GluingTypeID')
BEGIN
	ALTER TABLE CRMT2104 ADD GluingTypeID VARCHAR(50) NULL
END
-- 00/07/2021 - [Đình Ly] - End Add
