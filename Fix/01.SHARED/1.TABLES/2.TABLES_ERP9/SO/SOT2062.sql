-- <Summary>
---- Giá trị bổ sung ( màn hình phiếu báo giá SOF2021)
-- <History>
---- Create on 30/09/2019 by Nguyễn Thị Kiều Nga
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2062]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2062](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[APK_OT2101] [uniqueidentifier] NOT NULL,
	[Factor] [decimal](28, 8) NULL,	
	[ProfileCost] [decimal](28, 8) NULL,
	[InternalShipCost] [decimal](28, 8) NULL,
	[TaxImport] [decimal](28, 8) NULL,
	[CustomsCost] [decimal](28, 8) NULL,
	[CustomsInspectionCost] [decimal](28, 8) NULL,
	[TT_Cost] [decimal](28, 8) NULL,
	[LC_Open] [decimal](28, 8) NULL,
	[LC_Receice] [decimal](28, 8) NULL,
	[WarrantyCost] [decimal](28, 8) NULL,
	[InformType] [nvarchar](50) NULL,
	[TaxFactor1] [decimal](28, 8) NULL,
	[TaxFactor2] [decimal](28, 8) NULL,
	[TaxCost] [decimal](28, 8) NULL,
	[GuestsCost] [decimal](28, 8) NULL,
	[SurveyCost] [decimal](28, 8) NULL,
	[PlusCost] [decimal](28, 8) NULL,
	[TotalCost] [decimal](28, 8) NULL
 CONSTRAINT [PK_SOT2062] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--Modify by Kiều Nga Date 23/10/2019 Bổ sung trường hoa hồng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='SOT2062' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='SOT2062' AND col.name='Revenue')
	ALTER TABLE SOT2062 ADD Revenue decimal(28,8) Null 
END

--Modify by Kiều Nga Date 23/10/2019 Bổ sung trường giá trị cộng thêm
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='SOT2062' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='SOT2062' AND col.name='PlusSaleCost')
	ALTER TABLE SOT2062 ADD PlusSaleCost decimal(28,8) Null 
END

--Modify by Kiều Nga Date 24/10/2019 Bổ sung trường kế thừa NC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='SOT2062' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='SOT2062' AND col.name='InheritNC')
	ALTER TABLE SOT2062 ADD InheritNC TINYINT Null Default(0)
END

--Modify by Kiều Nga Date 24/10/2019 Bổ sung trường kế thừa NC KHCU
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='SOT2062' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='SOT2062' AND col.name='InheritKHCU')
	ALTER TABLE SOT2062 ADD InheritKHCU TINYINT Null Default(0)
END

--Modify by Kiều Nga Date 27/10/2019 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='SOT2062' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='SOT2062' AND col.name='RevenueDetail')
	ALTER TABLE SOT2062 ADD RevenueDetail NVARCHAR(MAX) NULL
END

--Modify by Kiều Nga Date 13/11/2019 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='SOT2062' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='SOT2062' AND col.name='DiscountAmount')
	ALTER TABLE SOT2062 ADD DiscountAmount decimal(28,8) Null
END

