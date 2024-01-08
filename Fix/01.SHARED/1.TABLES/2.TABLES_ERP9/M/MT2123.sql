
---- Create by Đình Ly on 26/10/2020 4:22:23 PM
---- Bảng dữ liệu chi tiết nghiệp vụ Định mức sản phẩm.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2123]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2123]
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

CONSTRAINT [PK_MT2123] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 03/12/2020 - Đình Ly: Bổ sung cột Version ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'RoutingID')
BEGIN
	ALTER TABLE MT2123 DROP COLUMN RoutingID
END

---------------- 09/12/2020 - Đình Ly: Bổ sung cột LossValue ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'LossValue')
BEGIN
	ALTER TABLE MT2123 ADD LossValue DECIMAL(28) NULL
END

---------------- 25/11/2022 - Đình Định: Bổ sung cột số lượng ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'Quantity')
BEGIN
	ALTER TABLE MT2123 ADD Quantity DECIMAL(28) NULL
END

---------------- 25/11/2022 - Đình Định: Bổ sung cột Lượng hao hụt ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'LossAmount')
BEGIN
	ALTER TABLE MT2123 ADD LossAmount DECIMAL(28) NULL
END

---------------- 28/11/2022 - Đình Định: Bổ sung cột Total ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'Total')
BEGIN
	ALTER TABLE MT2123 ADD Total DECIMAL(28) NULL
END

---------------- 28/11/2022 - Đình Định: Bổ sung cột Set up time ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'SetUpTime')
BEGIN
	ALTER TABLE MT2123 ADD SetUpTime DECIMAL(28) NULL
END

---------------- 16/12/2020 - Đình Ly: Bổ sung cột DisplayName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'DisplayName')
BEGIN
	ALTER TABLE MT2123 ADD DisplayName NVARCHAR(500) NULL
END

--Đức Tuyên - [28/11/2022] : Update kiểu dữ liệu
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2123' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2123' AND col.name='QuantitativeValue')
	
	ALTER TABLE MT2123 ALTER COLUMN QuantitativeValue DECIMAL(28,8) NULL
END

---------------- 03/02/2023 - Đình Định: Bổ sung cột Diễn giải chi tiết ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'DDescription')
BEGIN
	ALTER TABLE MT2123 ADD DDescription NVARCHAR(500) NULL
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2123' AND col.name = 'Specification')
BEGIN
	ALTER TABLE MT2123 ADD Specification NVARCHAR(500) NULL
END