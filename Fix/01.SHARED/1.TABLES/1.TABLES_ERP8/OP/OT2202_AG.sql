-- <Summary>
---- Customize Angel: Thông tin dự trù chi phí sản xuất kế thừa từ kế hoạch sản xuất từng công đoạn
-- <History>
---- Created by Tiểu Mai on 25/11/2016
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2202_AG]') AND type in (N'U'))
CREATE TABLE [dbo].[OT2202_AG](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritTransactionID] [nvarchar](50) NULL,
	[Quantity] [decimal](28, 8) NULL,
 CONSTRAINT [PK_OT2202_AG] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT2202_AG]') AND name = N'OT2202_AG_Index1')
DROP INDEX [OT2202_AG_Index1] ON [dbo].[OT2202_AG] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [OT2202_AG_Index1] ON [dbo].[OT2202_AG] 
(
	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
