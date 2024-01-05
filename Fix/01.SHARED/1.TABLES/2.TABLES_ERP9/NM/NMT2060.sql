IF NOT EXISTS (SELECT* FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT2060]') AND TYPE IN (N'U'))
BEGIN
-- <Summary>
---- Tạo bảng danh sách hồ sơ sức khỏe
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by:Trà Giang, Date: 20/09/2018
-- <Example>
---- 
/*-- <Example>

----*/

CREATE TABLE [dbo].[NMT2060]
(
[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
[DivisionID] VARCHAR(50) NOT NULL,

[VoucherNo] VARCHAR(50) NOT NULL,
[VoucherDate] DATETIME  NOT NULL,
 
[CreateUserID] VARCHAR(50) NULL,
[CreateDate] DATETIME NULL,
[LastModifyUserID] VARCHAR(50) NULL,
[LastModifyDate] DATETIME NULL,
[DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
[TranMonth] INT NOT NULL,
[TranYear] INT NOT NULL
CONSTRAINT [PK_NMT2060] PRIMARY KEY CLUSTERED
(
  [APK] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
 
 



 ---- Modified by Hồng Thảo on 22/10/2019: Bổ sung cột năm học, lớp, khối 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'NMT2060' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2060' AND col.name = 'SchoolYearID') 
   ALTER TABLE NMT2060 ADD SchoolYearID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2060' AND col.name = 'GradeID') 
   ALTER TABLE NMT2060 ADD GradeID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2060' AND col.name = 'ClassID') 
   ALTER TABLE NMT2060 ADD ClassID VARCHAR(50) NULL 


END