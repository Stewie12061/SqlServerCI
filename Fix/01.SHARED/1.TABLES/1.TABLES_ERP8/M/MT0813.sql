-- <Summary>
---- Bảng tạm phục vụ cho store MP0898
-- <History>
---- Create on 18/08/2021 by Nhựt Trường
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT0813]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[MT0813](
		[APK] [uniqueidentifier] DEFAULT NEWID(),
		[DivisionID] [nvarchar](50) NOT NULL,
		[PeriodID] [nvarchar](250) NULL,
		[ApportionID] [nvarchar](250) NULL,
		[ExpenseID] [nvarchar](250) NULL,
		[ProductID] [nvarchar](250) NULL,
		[ProductName] [nvarchar](MAX),
		[MaterialTypeID] [nvarchar](50) NULL,
		[MaterialID] [nvarchar](250) NULL,
		[ConvertedA] [DECIMAL](28, 8) NULL,
		[QuantityA] [DECIMAL](28, 8) NULL,
		[ProductQuantity] [DECIMAL](28, 8)NULL,
		[RateWastage]  [DECIMAL](28, 8) NULL,
		[RateWastage02]  [DECIMAL](28, 8) NULL,
		[WasteID] [nvarchar](250) NULL,
		[DebitQuantity] [DECIMAL](28, 8) NULL,
		[CreditQuantity] [DECIMAL](28, 8) NULL,
		[OrderQuantity] [DECIMAL](28, 8) NULL,
		[SOrderID] [nvarchar](250) NULL
	) ON [PRIMARY]
END