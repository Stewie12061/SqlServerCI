---- Create by Hồng Thảo on 06/10/2018
---- Tạo chương trình học theo tháng master 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2120]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2120]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ProgrammonthID] VARCHAR(50) NOT NULL,
  [VoucherDate] DATETIME NULL,
  [GradeID] VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2120] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


----Modify on 01/02/2019 by Hồng Thảo thêm cột TranMonth,TranYear, năm học 
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'TranMonth') 
   ALTER TABLE EDMT2120 ADD TranMonth INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'TranYear') 
   ALTER TABLE EDMT2120 ADD TranYear INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'TermID') 
   ALTER TABLE EDMT2120 ADD TermID VARCHAR(50) NULL 

END 



----Modify on 14/11/2019 by Hồng Thảo thêm cột đính kèm tiếng việt, đính kèm tiếng anh  
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'AttachUS') 
   ALTER TABLE EDMT2120 ADD AttachUS VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'AttachVN') 
   ALTER TABLE EDMT2120 ADD AttachVN VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'ClassID') 
   ALTER TABLE EDMT2120 ADD ClassID VARCHAR(50) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'Description') 
   ALTER TABLE EDMT2120 ALTER COLUMN [Description] NVARCHAR(MAX) NULL 




END 


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2120' AND xtype = 'U')
BEGIN 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'AttachVN') 
   ALTER TABLE EDMT2120 ALTER COLUMN AttachVN VARCHAR(50) NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'AttachUS') 
   ALTER TABLE EDMT2120 ALTER COLUMN AttachUS VARCHAR(50) NULL


END 


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2120' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'LinkAttachVN') 
   ALTER TABLE EDMT2120 ADD LinkAttachVN VARCHAR(MAX) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2120' AND col.name = 'LinkAttachUS') 
   ALTER TABLE EDMT2120 ADD LinkAttachUS VARCHAR(MAX) NULL


END 


 