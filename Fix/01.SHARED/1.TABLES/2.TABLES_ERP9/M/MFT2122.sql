
---- Create by Trọng Kiên on 07/01/2021 4:22:23 PM
---- Bảng dữ liệu chi tiết nghiệp vụ Định mức sản phẩm (bảng giả).

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MFT2122]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MFT2122]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NOT NULL,
	[APK_2120] UNIQUEIDENTIFIER NOT NULL,
	[DivisionID] VARCHAR(25) NOT NULL,
	[NodeTypeID] VARCHAR(50) NOT NULL,
	[NodeID] VARCHAR(50) NOT NULL,
	[NodeName] NVARCHAR(250) NOT NULL,
	[NodeParent] UNIQUEIDENTIFIER NULL,
	[NodeLevel] INT NULL,
	[NodeOrder] INT NULL,
	[UnitID] NVARCHAR(50) NULL,
	[QuantitativeTypeID] VARCHAR(50) NULL,
	[QuantitativeValue] DECIMAL(28) NULL,
	[MaterialGroupID] VARCHAR(50) NULL,
	[MaterialID] VARCHAR(50) NULL,
	[MaterialConstant] DECIMAL(28) NULL,
	[RoutingID] VARCHAR(50) NULL,
	[OutsourceID] VARCHAR(50) NULL,
	[DictatesID] VARCHAR(50) NULL,
	[PhaseID] VARCHAR(50) NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,

CONSTRAINT [PK_MFT2122] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 03/12/2020 - Trọng Kiên: Bổ sung cột Version ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MFT2122' AND col.name = 'RoutingID')
BEGIN
	ALTER TABLE MFT2122 DROP COLUMN RoutingID
END

---------------- 09/12/2020 - Đình Ly: Bổ sung cột Version ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MFT2122' AND col.name = 'LossValue')
BEGIN
	ALTER TABLE MFT2122 ADD LossValue DECIMAL(28) NULL
END

---------------- 16/12/2020 - Đình Ly: Bổ sung cột Description ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MFT2122' AND col.name = 'DisplayName')
BEGIN
	ALTER TABLE MFT2122 ADD DisplayName NVARCHAR(500) NULL
END