---- Create by Khâu Vĩnh Tâm on 12/3/2018 9:18:17 AM
---- Danh sách thông báo

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2090]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2090]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [InformID] VARCHAR(50) NULL,
  [InformName] NVARCHAR(250) NULL,
  [EffectDate] DATETIME NULL,
  [ExpiryDate] DATETIME NULL,
  [IsExpiryDate] TINYINT DEFAULT 0 NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [InformType] INT NULL,
  [InformDivisionID] VARCHAR(50) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [Content] NVARCHAR(MAX) NULL,
  [Disabled] TINYINT DEFAULT 0 NULL,
  [DeleteFlag] TINYINT DEFAULT 0 NULL,
  [RelatedToTypeID] INT DEFAULT 42 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2090] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 13/08/2019 - Vĩnh Tâm: Bổ sung cột IsCommon --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2090' AND col.name = 'IsCommon')
BEGIN
	ALTER TABLE OOT2090 ADD IsCommon TINYINT DEFAULT 0
END