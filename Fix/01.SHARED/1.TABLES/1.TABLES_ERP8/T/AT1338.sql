-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified by Tiểu Mai on 18/01/2016: Add columns Cấp số chia DivisorDecimal (Angel).
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1338]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1338](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[PromoteInventoryID] [nvarchar](50) NOT NULL,
	[PromoteQuantity] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	[PromotePercent] [decimal](28, 8) NULL,
	CONSTRAINT [PK_AT1338] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--- Tiểu Mai, 18/01/2016: Add columns
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1338' AND col.name = 'DivisorDecimal')
        ALTER TABLE AT1338 ADD	DivisorDecimal DECIMAL(28,8) NULL

------Modified by [Hoài Bảo] on [10/05/2022]: Bổ sung cột FromQuantity
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1338' AND col.name = 'FromQuantity')
BEGIN 
   ALTER TABLE AT1338 ADD FromQuantity DECIMAL(28,8) NULL
END

------Modified by [Hoài Bảo] on [10/05/2022]: Bổ sung cột ToQuantity
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1338' AND col.name = 'ToQuantity')
BEGIN 
   ALTER TABLE AT1338 ADD ToQuantity DECIMAL(28,8) NULL
END

------Modified by [Hoài Bảo] on [10/05/2022]: Bổ sung cột IsCombo
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1338' AND col.name = 'IsCombo')
BEGIN 
   ALTER TABLE AT1338 ADD IsCombo TINYINT NULL
END

------Modified by [Hoài Bảo] on [10/05/2022]: Bổ sung cột PromotionPrice
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1338' AND col.name = 'PromotionPrice')
BEGIN 
   ALTER TABLE AT1338 ADD PromotionPrice DECIMAL(28,8) NULL
END