---- Create by Nguyễn Thị Minh Hòa on 21/10/2018 2:29:31 PM
---- Nghiệp vụ xếp lớp - EDMF2020 -> lưu thông tin Học sinh
---- Select * from EDMT2021

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2021]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].EDMT2021(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[StudentID] VARCHAR(50) NULL,
	[IsTransfer] TINYINT DEFAULT (0) NULL,-- 0: không chuyển; 1: chuyển lớp
	[DeleteFlg] TINYINT DEFAULT (0) NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL
	
CONSTRAINT [PK_EDMT2021] PRIMARY KEY CLUSTERED
(
  [APK]
)
) ON [PRIMARY]

END
GO
