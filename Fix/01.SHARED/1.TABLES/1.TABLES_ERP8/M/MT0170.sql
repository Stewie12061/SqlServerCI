-- <Summary>
---- 
-- <History>
---- Create on 04/03/2016 by Bảo Anh: kế hoạch dự tính sản xuất thành phẩm (Angel)
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT0170]') AND type in (N'U'))
CREATE TABLE [dbo].[MT0170](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[TeamID] [nvarchar](50) NULL,
	[ProductTypeID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Quantity] decimal(28,8) NULL,
	[ApportionID] [nvarchar](50) NULL,
	[TableID] [nvarchar](50) NULL,
	[BlockID] [nvarchar](50) NULL,
	[EmployeeNum] [int] NULL,
	[EmployeePower] decimal(28,8) NULL,
	[Power] decimal(28,8) NULL,
	[Hours] decimal(28,8) NULL,
	[Orders] [int] NULL,
	[InheritTableID] [nvarchar](50) NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritTransactionID] [nvarchar](50) NULL,
 CONSTRAINT [PK_MT0170] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modified on 17/03/2019 by Kim Thư: Bổ sung IsFromMainPlan - Xác định dòng mặt hàng kế thừa kế hoạch gốc hay kế hoạch sx các công đoạn
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT0170' AND xtype ='U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0170' AND col.name = 'IsFromMainPlan')
    ALTER TABLE MT0170 ADD IsFromMainPlan TINYINT NULL
END 

---- Modified on 26/03/2019 by Kim Thư: Bổ sung PlanDate - Ngày bắt đầu sản xuất, AdjustReason - lý do điều chỉnh, PerformDate - Số ngày thực hiện
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='MT0170' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT0170' AND col.name='PlanDate')
	ALTER TABLE MT0170 ADD PlanDate DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT0170' AND col.name='AdjustReason')
	ALTER TABLE MT0170 ADD AdjustReason NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT0170' AND col.name='PerformDate')
	ALTER TABLE MT0170 ADD PerformDate DECIMAL(28,8) NULL

    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT0170' AND col.name='Change')
	ALTER TABLE MT0170 ADD Change TINYINT NULL
END 