-- <Summary>
---- Customize Angel: Thông tin phiếu xuất kho kế thừa từ đơn hàng
-- <History>
---- Create on 21/01/2016 by Bảo Anh
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT3206_AG]') AND type in (N'U'))
CREATE TABLE [dbo].[AT3206_AG](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[OrderID] [nvarchar](50) NULL,
	[OTransactionID] [nvarchar](50) NULL,
	[ActualQuantity] [decimal](28, 8) NULL,
 CONSTRAINT [PK_AT3206_AG] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT3206_AG]') AND name = N'AT3206_AG_Index1')
DROP INDEX [AT3206_AG_Index1] ON [dbo].[AT3206_AG] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [AT3206_AG_Index1] ON [dbo].[AT3206_AG] 
(
	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT3206_AG' AND col.name = 'DivisionID')
    ALTER TABLE AT3206_AG ALTER COLUMN DivisionID NVARCHAR(50) NOT NULL
