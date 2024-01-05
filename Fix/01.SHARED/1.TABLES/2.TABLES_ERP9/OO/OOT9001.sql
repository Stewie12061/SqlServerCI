---- Create by Nguyen Hoang Bao Thy on 02/12/2015 10:05:40 AM
---- Người duyệt

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT9001]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT9001]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] UNIQUEIDENTIFIER NOT NULL,
      [ApprovePersonID] VARCHAR(50) NOT NULL,
      [Level] INT NOT NULL,
      [Note] NVARCHAR(250) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL,
      [Status] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_OOT9001] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modified on 27/12/2018 by Bảo Anh: Bổ sung cột APKDetail là APK của OOT2010
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT9001' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT9001' AND col.name = 'APKDetail') 
			ALTER TABLE OOT9001 ADD APKDetail UNIQUEIDENTIFIER NULL
END

---- Modified on 12/03/2019 by Như Hàn: Bổ sung cột IsWatched: đánh dấu người duyệt đã xem phiếu duyệt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT9001' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT9001' AND col.name = 'IsWatched') 
			ALTER TABLE OOT9001 ADD IsWatched INT NULL DEFAULT 0

	---- Modified on 16/05/2022 by Văn Tài: Bổ sung cột IsWatched: đánh dấu người duyệt đã xem phiếu duyệt
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT9001' AND col.name = 'UseESign') 
			ALTER TABLE OOT9001 ADD UseESign INT NULL DEFAULT 0

	---- Modified on 24/11/2023 by Thanh Lượng: Bổ sung cột SameLevels: Người duyệt đồng cấp
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT9001' AND col.name = 'SameLevels') 
			ALTER TABLE OOT9001 ADD SameLevels INT NULL 
	---- Modified on 24/11/2023 by Thanh Lượng: Bổ sung cột IsSameLevels: là Người duyệt đồng cấp
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT9001' AND col.name = 'IsSameLevels') 
			ALTER TABLE OOT9001 ADD IsSameLevels TINYINT DEFAULT (0)
END

