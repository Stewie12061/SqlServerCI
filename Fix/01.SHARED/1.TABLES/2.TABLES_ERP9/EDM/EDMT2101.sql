---- Create by Hồng Thảo on 12/09/2018
---- Tạo lịch học cơ sở detail 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2101]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2101]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [FromHour] INT NULL,
  [ToHour] INT NULL,
  [Monday] NVARCHAR(250) NULL,
  [Tuesday] NVARCHAR(250) NULL,
  [Wednesday] NVARCHAR(250) NULL,
  [Thursday] NVARCHAR(250) NULL,
  [Friday] NVARCHAR(250) NULL,
  [Saturday] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR (50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR (50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2101] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

 
------Modified by Hồng Thảo on 13/11/2019: Bổ sung cột chủ nhật 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2101' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2101' AND col.name = 'Sunday') 
   ALTER TABLE EDMT2101 ADD Sunday NVARCHAR(MAX) NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2101' AND col.name = 'Monday') 
   ALTER TABLE EDMT2101 ALTER COLUMN Monday NVARCHAR(MAX) NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2101' AND col.name = 'Tuesday') 
   ALTER TABLE EDMT2101 ALTER COLUMN Tuesday NVARCHAR(MAX) NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2101' AND col.name = 'Wednesday') 
   ALTER TABLE EDMT2101 ALTER COLUMN Wednesday NVARCHAR(MAX) NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2101' AND col.name = 'Thursday') 
   ALTER TABLE EDMT2101 ALTER COLUMN Thursday NVARCHAR(MAX) NULL
 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2101' AND col.name = 'Friday') 
   ALTER TABLE EDMT2101 ALTER COLUMN Friday NVARCHAR(MAX) NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2101' AND col.name = 'Saturday') 
   ALTER TABLE EDMT2101 ALTER COLUMN Saturday NVARCHAR(MAX) NULL

END 