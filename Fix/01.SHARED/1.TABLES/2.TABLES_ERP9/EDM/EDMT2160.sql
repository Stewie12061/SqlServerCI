---- Create by Hồng Thảo on 17/10/2018
---- Tạo dự thu học phí master 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2160]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2160]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [EstimateID] VARCHAR(50) NOT NULL,
  [EstimateDate] DATETIME  NULL,
  [GradeID] VARCHAR(50) NULL,
  [ClassID] VARCHAR(50) NULL,
  [FeeID]  VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2160] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Hồng Thảo on 23/01/2019: Bổ sung năm học, TranMonth,TranYear 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2160' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2160' AND col.name = 'TranMonth') 
   ALTER TABLE EDMT2160 ADD TranMonth INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2160' AND col.name = 'TranYear') 
   ALTER TABLE EDMT2160 ADD TranYear INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2160' AND col.name = 'SchoolYearID') 
   ALTER TABLE EDMT2160 ADD SchoolYearID VARCHAR(50) NULL 
END 


 