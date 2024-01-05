IF NOT EXISTS (SELECT* FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT2061]') AND TYPE IN (N'U'))
BEGIN
-- <Summary>
---- Tạo bảng chi tiết hồ sơ sức khỏe
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 20/09/2018
-- <Example>

CREATE TABLE [dbo].[NMT2061]
(
[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
[APKMaster] UNIQUEIDENTIFIER NOT NULL,
[DivisionID] VARCHAR(50) NOT NULL,

[StudentID] VARCHAR(50) NOT NULL,
[Height] VARCHAR(50) NULL,
[Weight] VARCHAR(50) NULL,
[ActualQuantity] INT NULL,
[Content] VARCHAR(250) NULL,
[Notes] NVARCHAR(250) NULL,

[CreateUserID] VARCHAR(50) NULL,
[CreateDate] DATETIME NULL,
[LastModifyUserID] VARCHAR(50) NULL,
[LastModifyDate] DATETIME NULL,
[DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
[TranMonth] INT NOT NULL,
[TranYear] INT NOT NULL

CONSTRAINT [PK_NMT2061] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Hồng Thảo on 27/8/2019: Sủa lại kiểu dữ liệu trường 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'NMT2061' AND xtype = 'U')
BEGIN 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2061' AND col.name = 'Content') 
   ALTER TABLE  NMT2061 ALTER COLUMN Content NVARCHAR(250) NULL

END 


 ------Modified by Lương Mỹ on 28/08/2019: Bổ sung Năm học, Lớp, Khối
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2170' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2061' AND col.name = 'SchoolYearID') 
   ALTER TABLE NMT2061 ADD SchoolYearID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2061' AND col.name = 'GradeID') 
   ALTER TABLE NMT2061 ADD GradeID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2061' AND col.name = 'ClassID') 
   ALTER TABLE NMT2061 ADD ClassID VARCHAR(50) NULL 

END 