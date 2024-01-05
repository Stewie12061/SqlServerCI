---- Create by Nguyễn Thị Minh Hòa on 23/11/2018 2:29:31 PM
---- Nghiệp vụ Kết quả học tập
---- Select * from EDMT2050


IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2050]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE  [dbo].[EDMT2050]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherResult] VARCHAR(50) NOT NULL,
  [ResultDate] DATETIME NOT NULL,
  [SchoolYearID] VARCHAR(50) NOT NULL,
  [GradeID] VARCHAR(50) NOT NULL,
  [ClassID] VARCHAR(50) NOT NULL,
  [StudentID] VARCHAR(50) NULL,
  [Content] NVARCHAR(500)  NULL,
  [FeelingID] VARCHAR(50) NULL,
  [HoursFrom] INT NULL, 
  [HoursTo] INT NULL,  
  [EnglishVocabulary] NVARCHAR(500)  NULL,
  [TeacherNotes] NVARCHAR(500)  NULL,
  [ParentNotes] NVARCHAR(500)  NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2050] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END




------Modified by Hồng Thảo on 30/8/2019: Bổ sung cột SchoolYearID 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2050' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2050' AND col.name = 'SchoolYearID') 
   ALTER TABLE EDMT2050 ADD SchoolYearID VARCHAR(50) NULL


END 

 



