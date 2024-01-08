---- Create by Nguyễn Tấn Lộc on 1/21/2021 9:54:01 AM
---- Quản lý danh sách Folder (Dạng public)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2250]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2250]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [FolderID] VARCHAR(250) NULL,
  [FolderName] NVARCHAR(Max) NULL,
  [ParentNode] NVARCHAR(Max) NULL,
  [UserGroup] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2250] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 24/06/2022 - Văn Tài: Điều chỉnh cột UserGroup ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2250' AND col.name = 'UserGroup')
BEGIN
	ALTER TABLE OOT2250 ALTER COLUMN UserGroup VARCHAR(MAX);
END
