---- Create by Hồng Thảo on 26/10/2018
---- Nghiệp vụ quản lý tin tức 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2170]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2170]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [NewsID] VARCHAR(50) NOT NULL,
  [TitleName] NVARCHAR(250) NULL,
  [PublicDate] DATETIME  NOT NULL,
  [Image] IMAGE NULL,
  [Summary] NVARCHAR(4000) NULL,
  [Content] NVARCHAR(MAX) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2170] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



------Modified by Hồng Thảo on 23/01/2019: Bổ sung lớp, khối
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2170' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2170' AND col.name = 'GradeID') 
   ALTER TABLE EDMT2170 ADD GradeID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2170' AND col.name = 'ClassID') 
   ALTER TABLE EDMT2170 ADD ClassID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2170' AND col.name = 'NewTypeID') 
   ALTER TABLE EDMT2170 ADD NewTypeID VARCHAR(50) NULL 

END 


------Modified by Hồng Thảo on 16/5/2019: chuyển đổi kiểu dữ liệu Content
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2170' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2170' AND col.name = 'Content') 
   ALTER TABLE EDMT2170 ALTER COLUMN  Content NVARCHAR(MAX) NULL 


END 





