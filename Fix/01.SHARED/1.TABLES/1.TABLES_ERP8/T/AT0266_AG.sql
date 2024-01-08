-- <Summary>
---- Customize Angel: Thông tin hóa đơn bán hàng kế thừa phiếu xuất kho
-- <History>
---- Create on 27/01/2016 by Bảo Anh
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0266_AG]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0266_AG](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritTransactionID] [nvarchar](50) NULL,
	[Quantity] [decimal](28, 8) NULL,
 CONSTRAINT [PK_AT0266_AG] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT0266_AG]') AND name = N'AT0266_AG_Index1')
DROP INDEX [AT0266_AG_Index1] ON [dbo].[AT0266_AG] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [AT0266_AG_Index1] ON [dbo].[AT0266_AG] 
(
	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT0266_AG' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0266_AG' AND col.name='DivisionID')
	Alter Table AT0266_AG
		Alter column DivisionID [nvarchar](50) NOT NULL
END	