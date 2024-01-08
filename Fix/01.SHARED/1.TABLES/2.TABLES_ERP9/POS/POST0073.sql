---- Create by Dũng DV on 13/09/2019
---- Danh mục Phiếu dịch vụ

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST0073]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST0073]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [AreaID] VARCHAR(50) NOT NULL,
  [AreaName] NVARCHAR(250) NOT NULL,
  [FromDistance] INT NULL,
  [ToDistance] INT NULL,
  [ScoreFactor] INT NULL,
  
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
 
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME DEFAULT GETDATE() NOT NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_POST0073] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [AreaID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0073' AND col.name = 'FromDistance') 
   ALTER TABLE POST0073 ALTER COLUMN [FromDistance] FLOAT NULL 
   
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0073' AND col.name = 'ToDistance') 
   ALTER TABLE POST0073 ALTER COLUMN [ToDistance] FLOAT NULL 
