---- Create by Khâu Vĩnh Tâm on 8/15/2019 11:07:06 PM
---- Chi tiết bảng quy định hệ số lương mềm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[KPIT2031]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[KPIT2031]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [CompletionRate] INT NULL,
  [SoftwageCoefficient] DECIMAL(28,8) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_KPIT2031] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 17/08/2019 - Tấn Lộc: Bổ sung cột Description (Diễn giải) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'KPIT2031' AND col.name = 'Description')
BEGIN
	ALTER TABLE KPIT2031 ADD Description NVARCHAR(MAX)
END
