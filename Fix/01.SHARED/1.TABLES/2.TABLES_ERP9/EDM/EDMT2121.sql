---- Create by Hồng Thảo on 06/10/2018
---- Tạo chương trình theo tháng detail 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2121]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2121]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [Topic] NVARCHAR(250) NULL,
  [ActivityID] NVARCHAR(250) NULL,
  [SubjectID] VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR (50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR (50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2121] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

------Modified by Hồng Thảo on 15/11/2019: Bổ sung cột tuần, từ ngày, đến ngày 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2121' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2121' AND col.name = 'Week') 
   ALTER TABLE EDMT2121 ADD Week NVARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2121' AND col.name = 'FromDate') 
   ALTER TABLE EDMT2121 ADD FromDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2121' AND col.name = 'ToDate') 
   ALTER TABLE EDMT2121 ADD ToDate DATETIME NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2121' AND col.name = 'Topic') 
   ALTER TABLE EDMT2121 ALTER COLUMN Topic NVARCHAR(MAX) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2121' AND col.name = 'Description') 
   ALTER TABLE EDMT2121 ALTER COLUMN [Description] NVARCHAR(MAX) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2121' AND col.name = 'ActivityID') 
   ALTER TABLE EDMT2121 DROP COLUMN ActivityID

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2121' AND col.name = 'SubjectID') 
   ALTER TABLE EDMT2121 DROP COLUMN SubjectID


END 





