---- Create by Trà Giang on 26/11/2019
---- Phiếu yêu cầu khách hàng ( MAITHU = 107) Detail

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2101]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2101]
(
	[APK] [UNIQUEIDENTIFIER] DEFAULT NEWID() NOT NULL,
	[DivisionID] [VARCHAR](50) NOT NULL,
	[APKMaster] [UNIQUEIDENTIFIER] NOT NULL,
	[APKMInherited] [UNIQUEIDENTIFIER] NULL,
	[APKDInherited] [UNIQUEIDENTIFIER] NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[TranMonth] INT NULL,
	[TranYear] INT NULL,
  
    [InventoryID] VARCHAR(50) NOT NULL,
	[PaperTypeID] VARCHAR(50) NOT NULL,
	[MarketID] NVARCHAR(250) NULL,
	[ProductQuality] NVARCHAR(250) NULL,
	[Length] DECIMAL(28,8) NULL,
	[Width] DECIMAL(28,8) NULL,
	[Height] DECIMAL(28,8) NULL,
	[PrintSize] DECIMAL(28,8) NULL,
	[CutSize] DECIMAL(28,8) NULL,
	[LengthPaper] DECIMAL(28,8) NULL,
	[WidthPaper] DECIMAL(28,8) NULL,
	[ActualQuantity] DECIMAL(28,8) NULL,

	[SideColor1] TINYINT NULL,
	[ColorPrint01] NVARCHAR(250) NULL,
	[SideColor2] TINYINT NULL,
	[ColorPrint02] NVARCHAR(250) NULL,
	--[IsZenSuppo] TINYINT NULL,
	--[LengthZenSuppo] INT NULL,
	--[WidthZenSuppo] INT NULL,
	[DeliveryTime] DATETIME NULL,
	[FromDeliveryTime] INT NULL,
	[PaymentTime] INT NULL,
	[TransportAmount] NVARCHAR(250) NULL,
	[PaymentID] NVARCHAR(250) NULL,
	[IsContract] TINYINT NULL,
	[Percentage] DECIMAL(28,8) NULL,
	[Description] NVARCHAR(250) NULL,

	[IsDiscCD] TINYINT NULL,
	[IsSampleInventoryID] TINYINT NULL,
	[IsSampleEmail] TINYINT NULL,
	[IsFilm] TINYINT NULL,
	--[File] NVARCHAR(250) NULL,

	[InvenPrintSheet] VARCHAR(50) NULL,
	[InvenMold] VARCHAR(50) NULL,
	[Pack] VARCHAR(50) NULL,
	[OffsetPaper] VARCHAR(50) NULL,
	[PrintNumber] VARCHAR(50) NULL,
	[OtherProcessing] NVARCHAR(250) NULL,
	[FilmDate] DATETIME NULL,
	[LengthFilm] DECIMAL(28,8) NULL,
	[WidthFilm] DECIMAL(28,8) NULL,
	[StatusFilm] VARCHAR(25) NULL,
	[StatusMold] VARCHAR(25) NULL,
	[Design] NVARCHAR(250) NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NULL
 
CONSTRAINT [PK_CRMT2101] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified by Kiều Nga on 17/06/2020: chuyển từ kiểu DECIMAL(28,8) => NVARCHAR(50)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2101' AND xtype = 'U') 
BEGIN
    ALTER TABLE CRMT2101 ALTER COLUMN [Length] NVARCHAR(50) NULL
    ALTER TABLE CRMT2101 ALTER COLUMN [Width] NVARCHAR(50) NULL
    ALTER TABLE CRMT2101 ALTER COLUMN [Height] NVARCHAR(50) NULL
    ALTER TABLE CRMT2101 ALTER COLUMN [PrintSize] NVARCHAR(50) NULL
    ALTER TABLE CRMT2101 ALTER COLUMN [CutSize] NVARCHAR(50) NULL
    ALTER TABLE CRMT2101 ALTER COLUMN [LengthPaper] NVARCHAR(50) NULL
    ALTER TABLE CRMT2101 ALTER COLUMN [WidthPaper] NVARCHAR(50) NULL
END

-------------------- 22/12/2020 - Tấn Lộc: Bổ sung cột UsedIn, PrintTypeID, QuantityInBox, Weight, Bearingstrength, Humidity, Podium, BearingBCT, EdgeCompressionECT, PreferredValue, FileName, BoxType, SampleContent, ColorSample  --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'UsedIn')
BEGIN
	ALTER TABLE CRMT2101 ADD UsedIn NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'PrintTypeID')
BEGIN
	ALTER TABLE CRMT2101 ADD PrintTypeID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'QuantityInBox')
BEGIN
	ALTER TABLE CRMT2101 ADD QuantityInBox NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'Weight')
BEGIN
	ALTER TABLE CRMT2101 ADD Weight NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'Bearingstrength')
BEGIN
	ALTER TABLE CRMT2101 ADD Bearingstrength NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'Humidity')
BEGIN
	ALTER TABLE CRMT2101 ADD Humidity NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'Podium')
BEGIN
	ALTER TABLE CRMT2101 ADD Podium NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'BearingBCT')
BEGIN
	ALTER TABLE CRMT2101 ADD BearingBCT NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'EdgeCompressionECT')
BEGIN
	ALTER TABLE CRMT2101 ADD EdgeCompressionECT NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'PreferredValue')
BEGIN
	ALTER TABLE CRMT2101 ADD PreferredValue NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'FileName')
BEGIN
	ALTER TABLE CRMT2101 ADD FileName NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'BoxType')
BEGIN
	ALTER TABLE CRMT2101 ADD BoxType NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'SampleContent')
BEGIN
	ALTER TABLE CRMT2101 ADD SampleContent NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'ColorSample')
BEGIN
	ALTER TABLE CRMT2101 ADD ColorSample NVARCHAR(MAX) NULL
END


---- Modified by Viết Toàn on 24/07/2023: Bổ sung lưu vết APK_BomVersion mới nhất tại thời điểm lập YCKH
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2101' AND col.name = 'APK_BomVersion')
BEGIN
	ALTER TABLE CRMT2101 ADD APK_BomVersion VARCHAR(50) NULL
END
