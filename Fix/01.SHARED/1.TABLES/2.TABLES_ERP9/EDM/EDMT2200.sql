---- Create by Khánh Đoan on 16/12/2019
---- Nghiệp vụ Thay đổi mức đóng phí 
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2200]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2200]
(

  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50)  NULL,
  [SchoolYearID] VARCHAR(50)  NULL,
  [GradeID]  VARCHAR(50)  NULL,
  [ClassID]  VARCHAR(50)  NULL,
  [StudentID] VARCHAR(50)  NULL,						-- Mã học sinh
  [OldFeeID] VARCHAR(50)  NULL,							-- Biểu phí hiện tại
  [ImlementationDate] DATETIME,							-- Ngày áp dụng
  [AdmissionDate] DATETIME ,							-- Ngày đăng ký
  [NewStatusID] VARCHAR(50)  NULL,						-- Chuyển trạng thái
  [OldStatusID] VARCHAR(50)  NULL,						-- Trạng thái cũ
  [NewFeeID]    VARCHAR(50)  NULL,						-- Biểu phí mới
  [Used]        VARCHAR(50) NULL,						-- Bảng nghiệp vụ liên quan tới 
  [InheritVoucherID]        VARCHAR(50) NULL,           -- APK của Bảng nghiệp vụ Used
  [DeleteFlg] TINYINT DEFAULT (0) NULL, 
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2200] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Lương Mỹ on 16/3/2020: Bổ sung cột lưu thêm Cột lưu kế thừa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2200' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2200' AND col.name = 'InheritVoucherID') 
   ALTER TABLE EDMT2200 ADD InheritVoucherID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2200' AND col.name = 'Used') 
   ALTER TABLE EDMT2200 ADD Used VARCHAR(50) NULL

END 

 

 
 






