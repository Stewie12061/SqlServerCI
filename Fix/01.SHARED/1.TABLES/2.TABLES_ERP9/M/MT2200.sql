-- <Summary>
---- Master nghiệp vụ sắp xếp cont module M (Quản lý sản xuất)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Ly on 17/02/2021

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2200]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2200]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[VoucherNo] VARCHAR(50) NOT NULL,
	[VoucherDate] DATETIME NOT NULL,
	[CreateDate] DATETIME NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL

CONSTRAINT [PK_MT2200] PRIMARY KEY CLUSTERED
(
  [DivisionID] ASC,
  [VoucherNo]  ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


----------------------20/05/2021 - Minh Phúc: Thêm cột Notes---------------------
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT2200' AND xtype ='U') 
BEGIN
     If NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name =   'MT2200'  AND col.name = 'Notes')
     ALTER TABLE MT2200 ADD Notes NVARCHAR(1000) NULL
END