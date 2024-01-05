-- Create by VanTinh on 16/11/2018
-- Điều chuyển giáo viên master - EDMF2070

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2070]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2070]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	VoucherNo VARCHAR(50) NOT NULL,
	DecisionDate DATETIME NULL,
	PromoterID VARCHAR(50) NULL,
	DivisionIDTo VARCHAR(50) NULL,
	[Description] NVARCHAR(500) NULL,
	DeciderID VARCHAR(50) NULL,
	CreateUserID VARCHAR(50) NULL,
	CreateDate DATETIME NULL,
	LastModifyUserID VARCHAR(50) NULL,
	LastModifyDate DATETIME NULL,
	DeleteFlg TINYINT DEFAULT(0) NULL,

CONSTRAINT [PK_EDMT2070] PRIMARY KEY CLUSTERED
(
  [APK], [DivisionID]
)
) ON [PRIMARY]

END
GO

------Modified by Hồng Thảo on 4/12/2019: Bổ sung cột division cho DB chưa có
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2070' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2070' AND col.name = 'DivisionIDTo') 
   ALTER TABLE EDMT2070 ADD DivisionIDTo VARCHAR(50) NULL

END 

  