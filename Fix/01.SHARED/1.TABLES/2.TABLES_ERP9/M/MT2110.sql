---- Create by Đình Ly on 26/10/2020 4:22:23 PM
---- Bảng dữ liệu nghiệp vụ Cấu trúc sản phẩm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2110]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2110]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NOT NULL,
	[DivisionID] VARCHAR(25) NOT NULL,
	[NodeTypeID] VARCHAR(50) NOT NULL,
	[NodeID] VARCHAR(50) NOT NULL,
	[NodeName] NVARCHAR(250) NOT NULL,
	[NodeParent] UNIQUEIDENTIFIER NULL,
	[NodeLevel] INT NULL,
	[NodeOrder] INT NULL,
	[UnitID] NVARCHAR(250) NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
CONSTRAINT [PK_MT2110] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 16/12/2020 - Đình Ly: Bổ sung cột DisplayName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2110' AND col.name = 'DisplayName')
BEGIN
	ALTER TABLE MT2110 ADD DisplayName NVARCHAR(500) NULL
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2110' AND col.name = 'Specification')
BEGIN
	ALTER TABLE MT2110 ADD Specification NVARCHAR(500) NULL
END