-- Create by VanTinh on 20/10/2018
-- Điểm danh - EDMF2040

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2041]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2041]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NULL,
	StudentID VARCHAR(50) NULL,
	AvailableStatusID VARCHAR(50) NULL,
	CreateUserID VARCHAR(50) NULL,
	CreateDate DATETIME NULL,
	LastModifyUserID VARCHAR(50) NULL,
	LastModifyDate DATETIME NULL,
	DeleteFlg TINYINT DEFAULT(0) NULL,

CONSTRAINT [PK_EDMT2041] PRIMARY KEY CLUSTERED
(
  [APK]
)
) ON [PRIMARY]

END
GO


------Modified by Hồng Thảo on 16/5/2019: Bổ sung cột lý do 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2041' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2041' AND col.name = 'Reason') 
   ALTER TABLE EDMT2041 ADD Reason NVARCHAR(250) NULL 


END 


------Modified by Hồng Thảo on 23/10/2019: Bổ sung cột ngày tính tiền hoàn trả
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2041' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2041' AND col.name = 'IsException') 
   ALTER TABLE EDMT2041 ADD IsException  TINYINT DEFAULT(0) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2041' AND col.name = 'DateException') 
   ALTER TABLE EDMT2041 ADD DateException  DATETIME NULL


   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2041' AND col.name = 'InheritAPKAbsence') 
   ALTER TABLE EDMT2041 ADD InheritAPKAbsence  VARCHAR(50) NULL


END 



 
 

 