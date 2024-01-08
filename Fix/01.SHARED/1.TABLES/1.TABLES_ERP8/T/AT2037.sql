-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2037]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2037](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[ReTransactionID] [nvarchar](50) NOT NULL,
	[ReVoucherID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NULL,
	[Quantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[AdjustQuantity] [decimal](28, 8) NULL,
	[AdjustUnitPrice] [decimal](28, 8) NULL,
	[AdjutsOriginalAmount] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[SourceNo] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[LimitDate] [datetime] NULL,
	[Orders] [int] NOT NULL,
	[ObjectID] [nvarchar](50) NULL,
	[isAdjust] [tinyint] NOT NULL,
	CONSTRAINT [PK_AT2037] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

--- Add column
If Exists (Select * From sysobjects Where name = 'AT2037' and xtype ='U') 
Begin
	--- Modify on 18/01/2016 by Bảo Anh: Bổ sung mã vạch và số lượng thùng (customize Angel)
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2037' AND col.name = 'KITID')
		ALTER TABLE AT2037 ADD KITID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2037' AND col.name = 'KITQuantity')
		ALTER TABLE AT2037 ADD KITQuantity DECIMAL(28,8) NULL

	--- Modify on 28/01/2016 by Bảo Anh: Bổ sung SL kém phẩm chất và mất phẩm chất (customize Angel)
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2037' AND col.name = 'PoorQAQty')
		ALTER TABLE AT2037 ADD PoorQAQty DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2037' AND col.name = 'DeterioratingQAQty')
		ALTER TABLE AT2037 ADD DeterioratingQAQty DECIMAL(28,8) NULL
End