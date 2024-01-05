---- Create by Trương Tấn Thành on 9/9/2020 3:31:08 PM
---- Danh mục người theo dõi - S

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST9020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST9020]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [RelatedToID] VARCHAR(50) NULL,
  [TableID] VARCHAR(50) NULL,
  [FollowerID01] VARCHAR(50) NULL,
  [FollowerName01] NVARCHAR(250) NULL,
  [FollowerID02] VARCHAR(50) NULL,
  [FollowerName02] NVARCHAR(250) NULL,
  [FollowerID03] VARCHAR(50) NULL,
  [FollowerName03] NVARCHAR(250) NULL,
  [FollowerID04] VARCHAR(50) NULL,
  [FollowerName04] NVARCHAR(250) NULL,
  [FollowerID05] VARCHAR(50) NULL,
  [FollowerName05] NVARCHAR(250) NULL,
  [FollowerID06] VARCHAR(50) NULL,
  [FollowerName06] NVARCHAR(250) NULL,
  [FollowerID07] VARCHAR(50) NULL,
  [FollowerName07] NVARCHAR(250) NULL,
  [FollowerID08] VARCHAR(50) NULL,
  [FollowerName08] NVARCHAR(250) NULL,
  [FollowerID09] VARCHAR(50) NULL,
  [FollowerName09] NVARCHAR(250) NULL,
  [FollowerID10] VARCHAR(50) NULL,
  [FollowerName10] NVARCHAR(250) NULL,
  [FollowerID11] VARCHAR(50) NULL,
  [FollowerName11] NVARCHAR(250) NULL,
  [FollowerID12] VARCHAR(50) NULL,
  [FollowerName12] NVARCHAR(250) NULL,
  [FollowerID13] VARCHAR(50) NULL,
  [FollowerName13] NVARCHAR(250) NULL,
  [FollowerID14] VARCHAR(50) NULL,
  [FollowerName14] NVARCHAR(250) NULL,
  [FollowerID15] VARCHAR(50) NULL,
  [FollowerName15] NVARCHAR(250) NULL,
  [FollowerID16] VARCHAR(50) NULL,
  [FollowerName16] NVARCHAR(250) NULL,
  [FollowerID17] VARCHAR(50) NULL,
  [FollowerName17] NVARCHAR(250) NULL,
  [FollowerID18] VARCHAR(50) NULL,
  [FollowerName18] NVARCHAR(250) NULL,
  [FollowerID19] VARCHAR(50) NULL,
  [FollowerName19] NVARCHAR(250) NULL,
  [FollowerID20] VARCHAR(50) NULL,
  [FollowerName20] NVARCHAR(250) NULL,
  [HashTags01] NVARCHAR(250) NULL,
  [HashTags02] NVARCHAR(250) NULL,
  [HashTags03] NVARCHAR(250) NULL,
  [HashTags04] NVARCHAR(250) NULL,
  [HashTags05] NVARCHAR(250) NULL,
  [HashTags06] NVARCHAR(250) NULL,
  [HashTags07] NVARCHAR(250) NULL,
  [HashTags08] NVARCHAR(250) NULL,
  [HashTags09] NVARCHAR(250) NULL,
  [HashTags10] NVARCHAR(250) NULL,
  [TypeFollow] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [RelatedToTypeID] INT NULL
CONSTRAINT [PK_ST9020] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 04/08/2022 - Tẫn Lộc: Bổ sung cột thêm 30 cột Người theo dỗi ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID21')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID21 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName21')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName21 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID22')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID22 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName22')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName22 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID23')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID23 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName23')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName23 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID24')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID24 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName24')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName24 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID25')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID25 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName25')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName25 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID26')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID26 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName26')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName26 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID27')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID27 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName27')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName27 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID28')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID28 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName28')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName28 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID29')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID29 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName29')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName29 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID30')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID30 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName30')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName30 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID31')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID31 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName31')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName31 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID32')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID32 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName32')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName32 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID33')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID33 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName33')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName33 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID34')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID34 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName34')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName34 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID35')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID35 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName35')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName35 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID36')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID36 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName36')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName36 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID37')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID37 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName37')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName37 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID38')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID38 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName38')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName38 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID39')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID39 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName39')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName39 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID40')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID40 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName40')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName40 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID41')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID41 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName41')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName41 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID42')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID42 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName42')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName42 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID43')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID43 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName43')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName43 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID44')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID44 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName44')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName44 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID45')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID45 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName45')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName45 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID46')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID46 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName46')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName46 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID47')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID47 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName47')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName47 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID48')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID48 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName48')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName48 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID49')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID49 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName49')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName49 NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerID50')
BEGIN
	ALTER TABLE ST9020 ADD FollowerID50 VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST9020' AND col.name = 'FollowerName50')
BEGIN
	ALTER TABLE ST9020 ADD FollowerName50 NVARCHAR(500) NULL
END