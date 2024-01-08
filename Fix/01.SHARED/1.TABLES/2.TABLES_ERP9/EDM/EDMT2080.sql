---- Create by Nguyễn Thị Minh Hòa on 27/11/2018 2:29:31 PM
---- Nghiệp vụ Quyết định nghỉ học
---- Select * from EDMT2080

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2080]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE  [dbo].[EDMT2080]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherLeaveSchool] VARCHAR(50) NOT NULL,
  [DecisiveDate] DATETIME NOT NULL,
  [ProponentID] VARCHAR(50) NOT NULL,
  [StudentID] VARCHAR(50) NOT NULL,
  [LeaveDate] DATETIME NOT NULL,
  [Reason] NVARCHAR(500)  NULL,
  [DeciderID] VARCHAR(50)  NULL,
  [Description] NVARCHAR(500)  NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
  
CONSTRAINT [PK_EDMT2080] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END




------Modified by Hồng Thảo on 11/4/2019: Bổ sung cột trạng thái cũ từ hồ sơ học sinh để phục vụ cho xóa phiếu sẽ cập nhật trạng thái lại 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2080' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'OldStatusID') 
   ALTER TABLE EDMT2080 ADD OldStatusID VARCHAR(50) NULL

END 


------Modified by Hồng Thảo on 10/9/2019: Bổ sung cột năm học, khối, lớp
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2080' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'SchoolYearID') 
   ALTER TABLE EDMT2080 ADD SchoolYearID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'ArrangeClassID') 
   ALTER TABLE EDMT2080 ADD ArrangeClassID VARCHAR(50) NULL



END 


------Modified by Hồng Thảo on 11/9/2019: Bổ sung cột trạng thái cũ từ xếp lớp để phục vụ cho xóa phiếu sẽ cập nhật trạng thái lại 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2080' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'OldStatusArrID') 
   ALTER TABLE EDMT2080 ADD OldStatusArrID VARCHAR(50) NULL

END 
 
 ------Modified by Khánh Đoan on 19/11/2019: Bổ sung cột check chọn  học sinh ra trường
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2080' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'IsGraduate') 
   ALTER TABLE EDMT2080 ADD IsGraduate TINYINT DEFAULT (0) NULL

END 
 


 ------Modified by Hồng Thảo on 19/2/2020: Bổ sung cột lưu vết APKMaster, ghi chú 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2080' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'APKVoucher') 
   ALTER TABLE EDMT2080 ADD APKVoucher VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'Note') 
   ALTER TABLE EDMT2080 ADD Note NVARCHAR(500) NULL

END 
 

  ------Modified by Lương Mỹ on 11/3/2020: Bổ sung cột lưu thêm Khối, Lớp
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2080' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'GradeID') 
   ALTER TABLE EDMT2080 ADD GradeID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'ClassID') 
   ALTER TABLE EDMT2080 ADD ClassID VARCHAR(50) NULL

END 

 ------Modified by Đình Hòa on 12/04/2021: Bổ sung cột check chọn  học sinh lên lớp
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2080' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2080' AND col.name = 'IsClassUp') 
   ALTER TABLE EDMT2080 ADD IsClassUp TINYINT DEFAULT (0) NULL
END 
 