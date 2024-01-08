---- Create by Cao Thị Phượng on 10/4/2017 3:43:48 PM
---- Danh mục trạng thái

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1040]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT1040]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [StatusID] VARCHAR(50) NOT NULL,
  [StatusName] NVARCHAR(250) NOT NULL,
  [Orders] NVARCHAR(250) NULL,
  [Color] VARCHAR(50) NULL,
  [RelatedToTypeID] INT DEFAULT 45 NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [StatusType] TINYINT DEFAULT (0) NULL
CONSTRAINT [PK_OOT1040] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [StatusID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 12/11/2019 - Vĩnh Tâm: Bổ sung cột SystemStatus ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1040' AND col.name = 'SystemStatus')
BEGIN
	ALTER TABLE OOT1040 ADD SystemStatus TINYINT DEFAULT 0
END

---------------- 02/01/2020 - Đình Ly: Bổ sung cột Bổ sung cột StatusNameE ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1040' AND col.name = 'StatusNameE ')
BEGIN
	ALTER TABLE OOT1040 ADD StatusNameE NVARCHAR(250) NULL
END

