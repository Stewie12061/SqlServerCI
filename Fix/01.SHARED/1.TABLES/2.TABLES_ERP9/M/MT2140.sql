---- Create by Mai Trọng Kiên on 2/1/2021 3:07:16 PM
---- Kế hoạch sản xuất

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2140]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2140]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL
CONSTRAINT [PK_MT2140] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 16/04/2021 - Trọng Kiên: Bổ sung cột TranMonth ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2140' AND col.name = 'TranMonth')
BEGIN
	ALTER TABLE MT2140 ADD TranMonth INT NULL
END

---------------- 16/04/2021 - Trọng Kiên: Bổ sung cột TranYear ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2140' AND col.name = 'TranYear')
BEGIN
	ALTER TABLE MT2140 ADD TranYear INT NULL
END

---------------- 16/04/2021 - Trọng Kiên: Bổ sung cột Description ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2140' AND col.name = 'Description')
BEGIN
	ALTER TABLE MT2140 ADD Description NVARCHAR(MAX) NULL
END

---------------- 08/06/2021 - Đình Hòa: Bổ sung cột kế thừa InheritSOT2080 & InheritOrderProduce ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2140' AND col.name = 'InheritSOT2080')
BEGIN
	ALTER TABLE MT2140 ADD InheritSOT2080  TINYINT DEFAULT (0) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2140' AND col.name = 'InheritOrderProduce')
BEGIN
	ALTER TABLE MT2140 ADD InheritOrderProduce  TINYINT DEFAULT (0) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2140' AND col.name = 'InheritPlan')
BEGIN
	ALTER TABLE MT2140 ADD InheritPlan  TINYINT DEFAULT (0) NULL
END

---------------- 16/04/2021 - Trọng Kiên: Bổ sung cột Description ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2140' AND col.name = 'DescriptionSearch')
BEGIN
	ALTER TABLE MT2140 ADD DescriptionSearch NVARCHAR(MAX) NULL
END