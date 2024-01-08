﻿---- Create by Phan thanh hoàng vũ on 23/11/2015 2:53:37 PM
---- Danh mục địa điểm (LAVO Bảng AT0133)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0141]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CT0141]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [StationID] VARCHAR(50) NOT NULL,
      [StationName] NVARCHAR(250) NULL,
      [Address] NVARCHAR(500) NULL,
      [StreetNo] NVARCHAR(100) NULL,
      [Street] NVARCHAR(250) NULL,
      [Ward] NVARCHAR(250) NULL,
      [DeliveryCityID] NVARCHAR(250) NULL,
      [CityID] VARCHAR(50) NULL,
      [Description] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT 0 NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [IsCommon] TINYINT DEFAULT 0 NOT NULL
    CONSTRAINT [PK_CT0141] PRIMARY KEY CLUSTERED
      (
		  [DivisionID],
		  [StationID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


IF EXISTS (SELECT * FROM sysobjects WHERE NAME='CT0141' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CT0141' AND col.name='Latitude')
	ALTER TABLE CT0141 ADD Latitude decimal(28, 8) DEFAULT 0

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CT0141' AND col.name='Longitude')
	ALTER TABLE CT0141 ADD Longitude decimal(28, 8) DEFAULT 0

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CT0141' AND col.name='TypeObject')
	ALTER TABLE CT0141 ADD TypeObject tinyint DEFAULT 0
END