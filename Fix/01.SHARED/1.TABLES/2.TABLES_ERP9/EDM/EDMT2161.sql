--- Create by Hồng Thảo on 17/10/2018
---- Tạo dự thu học phí detail học sinh

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2161]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2161]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [StudentID] VARCHAR(50) NOT NULL,
  [AttendStudy] DECIMAL(28,2) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR (50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR (50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2161] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



------Modified by Hồng Thảo on 12/8/2019: Bổ sung cột số ngày nghỉ xin trước 1 ngày và số ngày nghỉ xin trc 2 ngày 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2161' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2161' AND col.name = 'AbsentPermission1') 
   ALTER TABLE EDMT2161 ADD AbsentPermission1 TINYINT DEFAULT (0) NOT NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2161' AND col.name = 'AbsentPermission2') 
   ALTER TABLE EDMT2161 ADD AbsentPermission2 TINYINT DEFAULT (0) NOT NULL


END 


