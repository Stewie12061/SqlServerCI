---- Create by Hồng Thảo on 12/10/2018
---- Nghiệp vụ Bảo lưu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2150]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2150]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ReserveID] VARCHAR (50) NOT NULL,
  [ReserveDate] DATETIME NULL,
  [ProposerID] VARCHAR(50) NULL,
  [GradeID] VARCHAR(50) NULL,
  [ClassID] VARCHAR(50) NULL,
  [StudentID] VARCHAR(50) NULL,
  [ReservePeriod] DECIMAL(18,2) NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [Reason] NVARCHAR (250) NULL,
  [Description] NVARCHAR (250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2150] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

------Modified by Hồng Thảo on 12/02/2019: Bổ sung năm học
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2150' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2150' AND col.name = 'SchoolYearID') 
   ALTER TABLE EDMT2150 ADD SchoolYearID VARCHAR(50) NULL 
END 


------Modified by Hồng Thảo on 11/4/2019: Bổ sung cột trạng thái cũ từ hồ sơ học sinh để phục vụ cho xóa phiếu sẽ cập nhật trạng thái lại 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2150' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2150' AND col.name = 'OldStatusID') 
   ALTER TABLE EDMT2150 ADD OldStatusID VARCHAR(50) NULL

END 

------Modified by Hồng Thảo on 11/9/2019: Bổ sung cột trạng thái cũ từ xếp lớp để phục vụ cho xóa phiếu sẽ cập nhật trạng thái lại 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2150' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2150' AND col.name = 'OldStatusArrID') 
   ALTER TABLE EDMT2150 ADD OldStatusArrID VARCHAR(50) NULL

END 

------Modified by Lương Mỹ on 26/03/2020: Bổ sung lưu biểu phí
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2150' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2150' AND col.name = 'FeeID') 
   ALTER TABLE EDMT2150 ADD FeeID VARCHAR(50) NULL

END 