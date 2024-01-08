---- Create by hochuy on 10/11/2019 2:18:52 PM
---- Địa chỉ giao hàng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT101011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT101011]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [APKMaster] VARCHAR(50) NULL,
  [DeliveryAddress] NVARCHAR(250) NULL,
  [DeliveryWard] NVARCHAR(50) NULL,
  [DeliveryDistrictID] NVARCHAR(50) NULL,
  [DeliveryCityID] NVARCHAR(50) NULL,
  [DeliveryPostalCode] NVARCHAR(50) NULL,
  [DeliveryCountryID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL
CONSTRAINT [PK_CRMT101011] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='CRMT101011' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CRMT101011' AND col.name='Latitude')
	ALTER TABLE CRMT101011 ADD Latitude decimal(28, 8) DEFAULT 0

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CRMT101011' AND col.name='Longitude')
	ALTER TABLE CRMT101011 ADD Longitude decimal(28, 8) DEFAULT 0

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CRMT101011' AND col.name='Distance')
	ALTER TABLE CRMT101011 ADD Distance decimal(28, 8) DEFAULT 0

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CRMT101011' AND col.name='RouteID')
	ALTER TABLE CRMT101011 ADD RouteID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CRMT101011' AND col.name='StationID')
	ALTER TABLE CRMT101011 ADD StationID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CRMT101011' AND col.name='IsDelivery')
	ALTER TABLE CRMT101011 ADD IsDelivery TINYINT DEFAULT NULL
END