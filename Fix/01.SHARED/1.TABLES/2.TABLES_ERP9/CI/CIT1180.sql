---- Create by Nhựt Trường on 17/01/2022 
---- Lưu dữ liệu mối quan hệ ASM-SUP-SALES-DEALER

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1180]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1180]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [UserID] NVARCHAR(50) NOT NULL,
  [SaleID] NVARCHAR(50) NOT NULL,
  [DealerID] NVARCHAR(50) NOT NULL,
  [SUPID] NVARCHAR(50) NOT NULL,
  [ASMID] NVARCHAR(50) NOT NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
CONSTRAINT [PK_CIT1180] PRIMARY KEY CLUSTERED
(
	[DivisionID],
	[UserID],
	[SaleID],
	[SUPID],
	[ASMID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 24/12/2019 - Tấn Lộc: Bổ sung cột CreateDate, LastModifyDate --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CIT1180' AND col.name = 'CreateDate')
BEGIN
	ALTER TABLE CIT1180 ADD CreateDate DATETIME NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CIT1180' AND col.name = 'LastModifyDate')
BEGIN
	ALTER TABLE CIT1180 ADD LastModifyDate DATETIME NULL
END

-------------------- 14/08/2023 - Thanh Lượng: Bổ sung cột RSDID (Regional Sales Director), NDID (National Director) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CIT1180' AND col.name = 'RSDID')
BEGIN
	ALTER TABLE CIT1180 ADD RSDID NVARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CIT1180' AND col.name = 'NDID')
BEGIN
	ALTER TABLE CIT1180 ADD NDID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CIT1180' AND col.name = 'DealerID')
BEGIN
	ALTER TABLE CIT1180 ALTER COLUMN DealerID NVARCHAR(50) NOT NULL
END

ALTER TABLE CIT1180 DROP CONSTRAINT [PK_CIT1180];
ALTER TABLE CIT1180 ADD constraint [PK_CIT1180] Primary key(
	[DivisionID],
	[UserID],
	[DealerID],
	[SaleID],
	[SUPID],
	[ASMID]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]