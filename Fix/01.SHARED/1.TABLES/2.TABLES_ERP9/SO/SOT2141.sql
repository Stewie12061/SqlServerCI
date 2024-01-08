-- <Summary>
---- Bảng chi tiết phương án kinh doanh
-- <History>
---- Create on 04/08/2021 by Kiều Nga
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2141]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2141](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[InventoryID] [nvarchar](50) NULL,
	[Specification] [nvarchar](MAX) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Area] [decimal](28, 8) NULL, -- Diện tích
	[Quantity] [decimal](28, 8) NULL,
	[Coefficient][decimal](28, 8) NULL,
	[CostPrice] [decimal](28, 8) NULL, 
	[UnitPrice] [decimal](28, 8) NULL,
	[Profit] [decimal](28, 8) NULL,
	[TotalCostPrice] [decimal](28, 8) NULL,
	[CostPriceRate] [decimal](28, 8) NULL,
	[Revenue] [decimal](28, 8) NULL,
	[TotalProfit] [decimal](28, 8) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,	
	[Notes] [nvarchar](250) NULL,
	[Ana01ID] [nvarchar](50) NULL, -- MPT mặt hàng Ana01 --> Ana10
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,	
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[Ana06ID] [nvarchar](50) NULL,
	[Ana07ID] [nvarchar](50) NULL,
	[Ana08ID] [nvarchar](50) NULL,	
	[Ana09ID] [nvarchar](50) NULL,
	[Ana10ID] [nvarchar](50) NULL,
	[S01ID] [nvarchar](50) NULL, -- Quy cách S01 --> S20
	[S02ID] [nvarchar](50) NULL,
	[S03ID] [nvarchar](50) NULL,	
	[S04ID] [nvarchar](50) NULL,
	[S05ID] [nvarchar](50) NULL,
	[S06ID] [nvarchar](50) NULL,
	[S07ID] [nvarchar](50) NULL,
	[S08ID] [nvarchar](50) NULL,	
	[S09ID] [nvarchar](50) NULL,
	[S10ID] [nvarchar](50) NULL,
	[S11ID] [nvarchar](50) NULL,
	[S12ID] [nvarchar](50) NULL,
	[S13ID] [nvarchar](50) NULL,	
	[S14ID] [nvarchar](50) NULL,
	[S15ID] [nvarchar](50) NULL,
	[S16ID] [nvarchar](50) NULL,
	[S17ID] [nvarchar](50) NULL,
	[S18ID] [nvarchar](50) NULL,	
	[S19ID] [nvarchar](50) NULL,
	[S20ID] [nvarchar](50) NULL,
	[Status] [Tinyint] NULL DEFAULT (0),
	[APKMaster_9000] [nvarchar](50) NULL,
	[ApproveLevel] [int] NULL DEFAULT (0),
	[ApprovingLevel] [int] NULL DEFAULT (0),
	[InheritTableID] [varchar](50) NULL,
	[InheritVoucherID] [varchar](50) NULL,
	[InheritTransactionID] [varchar](50) NULL,
	[DeleteFlag] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL
 CONSTRAINT [PK_SOT2141] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

