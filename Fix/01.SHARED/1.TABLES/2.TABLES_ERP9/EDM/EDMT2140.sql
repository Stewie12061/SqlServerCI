---- Create by Hồng Thảo on 10/10/2018
---- Tạo điều chuyển học sinh 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2140]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2140]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TranferStudentNo] VARCHAR(50) NOT NULL,
  [DateTranfer] DATETIME NULL,
  [ProponentID] VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [StudentID] VARCHAR(50) NULL,
  [FromEffectiveDate] DATETIME NULL,
  [ToEffectiveDate] DATETIME NULL,
  [SchoolIDTo] VARCHAR(50) NULL,
  [GradeIDTo] VARCHAR(50) NULL,
  [ClassIDTo] VARCHAR(50) NULL,
  [Reason] NVARCHAR(250) NULL,
  [Approver1ID] VARCHAR(50) NULL,
  [Approver2ID] VARCHAR(50) NULL,
  [Approver3ID] VARCHAR(50) NULL,
  [Approver4ID] VARCHAR(50) NULL,
  [Approver5ID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2140] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END




------Modified by Hồng Thảo on 24/01/2019: Bổ sung xếp lớp chuyển đi, xếp lớp chuyển đến, lớp khối, 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2140' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2140' AND col.name = 'ArrangeClassIDTo') 
   ALTER TABLE EDMT2140 ADD ArrangeClassIDTo VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2140' AND col.name = 'ArrangeClassIDFrom') 
   ALTER TABLE EDMT2140 ADD ArrangeClassIDFrom VARCHAR(50) NULL

END 


------Modified by Hồng Thảo on 11/4/2019: Bổ sung cột trạng thái cũ từ xếp lớp để phục vụ cho xóa phiếu sẽ cập nhật trạng thái lại 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2140' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2140' AND col.name = 'OldStatusID') 
   ALTER TABLE EDMT2140 ADD OldStatusID VARCHAR(50) NULL

END 












