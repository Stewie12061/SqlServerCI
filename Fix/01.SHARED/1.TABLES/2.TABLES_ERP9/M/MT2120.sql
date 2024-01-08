---- Create by Đình Ly on 26/10/2020 4:22:23 PM
---- Modified by Lê Hoàng on 07/06/2021 : bổ sung trường RefAPK lưu vết khi kế thừa Cấu trúc sản phẩm 
---- Bảng dữ liệu nghiệp vụ Định mức sản phẩm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2120]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2120]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] VARCHAR(25) NOT NULL,
	[NodeTypeID] VARCHAR(50) NOT NULL,
	[NodeID] VARCHAR(50) NOT NULL,
	[NodeName] NVARCHAR(500) NOT NULL,
	[InheritID] VARCHAR(50) NULL,
	[UnitID] VARCHAR(50) NULL,
	[ObjectID] VARCHAR(50) NULL,
	[Description] NVARCHAR(500) NULL,
	[StartDate] DATETIME NULL,
	[EndDate] DATETIME NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,

CONSTRAINT [PK_MT2120] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 03/12/2020 - Đình Ly: Bổ sung cột Version ----------------

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2120' AND col.name = 'Version')
BEGIN
	ALTER TABLE MT2120 ADD Version INT NULL
END

---------------- 09/12/2020 - Đình Ly: Bổ sung cột RoutingID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2120' AND col.name = 'RoutingID')
BEGIN
	ALTER TABLE MT2120 ADD RoutingID VARCHAR(50) NULL
END

---------------- 05/01/2021 - Trọng Kiên: Bổ sung cột QuantityVersion ----------------

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2120' AND col.name = 'QuantityVersion')
BEGIN
	ALTER TABLE MT2120 ADD QuantityVersion INT NULL
END

---------------- 07/06/2021 - Lê Hoàng: Bổ sung cột RefTable, RefAPK ----------------

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2120' AND col.name = 'RefTable')
BEGIN
	ALTER TABLE MT2120 ADD RefTable VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2120' AND col.name = 'RefAPK')
BEGIN
	ALTER TABLE MT2120 ADD RefAPK VARCHAR(50) NULL
END

---------------- 25/11/2022 - Đình Định: Bổ sung cột Số lượng thành phẩm ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2120' AND col.name = 'QuantityProduct')
BEGIN
	ALTER TABLE MT2120 ADD QuantityProduct INT NULL
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2120' AND col.name = 'Specification')
BEGIN
	ALTER TABLE MT2120 ADD Specification NVARCHAR(500) NULL
END