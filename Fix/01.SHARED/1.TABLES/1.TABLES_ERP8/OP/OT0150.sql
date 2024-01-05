-- <Summary>
---- 
-- <History>
---- Create by Tiểu Mai on 19/01/2016: Add table detail for Angel (CustomizeIndex = 57) 
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT0150]') AND type in (N'U'))
CREATE TABLE [dbo].[OT0150](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,	
	[AVGTwoMonth] [decimal](28, 8) NULL,
	[AVGSixMonth] [decimal](28, 8) NULL,
	[FactorDecimal] [decimal](28, 8) NULL,
	[EstimateQuantity] [decimal](28, 8) NULL,
	[Price] [decimal](28, 8) NULL,
	[EstimateAmount] [decimal](28, 8) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_OT0150] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID],	
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--- 22/10/2020 - Trọng Kiên: Bổ sung cột EstimateConvertedAmount
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT0150' AND col.name = 'EstimateConvertedAmount')
BEGIN
	ALTER TABLE OT0150 ADD EstimateConvertedAmount DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='OT0150' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT0150' AND col.name='DivisionID')
	Alter Table OT0150
		Alter column DivisionID [nvarchar](50) NOT NULL
END	

