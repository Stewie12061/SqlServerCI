-- <Summary>
---- Bảng chi tiết phiếu báo giá Sale (Detail)
-- <History>
---- Create on 28/07/2021 by Đình Hoà
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2121]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2121](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[InventoryID] [nvarchar](50) NULL,
	[Specification] [nvarchar](MAX) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Area] [decimal](28, 8) NULL, -- Diện tích
	[QuoQuantity] [decimal](28, 8) NULL,
	[QuoCoefficient][decimal](28, 8) NULL,
	[UnitPriceInherit] [decimal](28, 8) NULL, -- Đơn giá kế thừa
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,
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
	[Notes] [nvarchar](250) NULL,
	[AttachFileName] [nvarchar](Max) NULL,
	[InheritTableID] [varchar](50) NULL,
	[InheritVoucherID] [varchar](50) NULL,
	[InheritTransactionID] [varchar](50) NULL,
	[DeleteFlag] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL
 CONSTRAINT [PK_SOT2121] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--[Kiều Nga] Create New [06/08/2021] check kế thừa sang báo giá Sale
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'IsInherit')
	BEGIN
    ALTER TABLE SOT2121 ADD [IsInherit] [tinyint] default(0) NULL
	END
END

--[ĐÌnh Hoà] Create New [24/08/2021] đánh số thứ tự cho mặt hàng (Inventory)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'OrderInv')
	BEGIN
    ALTER TABLE SOT2121 ADD [OrderInv] [INT] NULL
	END
END

--[Đình Ly] Create New [25/08/2021] Thứ tự mặt hàng được sắp xếp trên lưới.
--[Văn Tài] Updated	   [26/08/2021] Điều chỉnh lại cho code update giá trị.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'OrderNo')
	BEGIN
    ALTER TABLE SOT2121 ADD OrderNo INT NULL
	END
END
--[ĐÌnh Hoà] Create New [25/08/2021] bổ sung cột FirePrice
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'FirePrice')
	BEGIN
    ALTER TABLE SOT2121 ADD [FirePrice] NVARCHAR(100) NULL
	END
END

--[ĐÌnh Hoà] Create New [25/08/2021] bổ sung cột LengthSize
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'LengthSize')
	BEGIN
    ALTER TABLE SOT2121 ADD [LengthSize] [decimal](28, 8) NULL
	END
END

--[ĐÌnh Hoà] Create New [25/08/2021] bổ sung cột WithSize
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'WithSize')
	BEGIN
    ALTER TABLE SOT2121 ADD [WithSize] [decimal](28, 8) NULL
	END
END

--[ĐÌnh Hoà] Create New [25/08/2021] bổ sung cột HeightSize
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'HeightSize')
	BEGIN
    ALTER TABLE SOT2121 ADD [HeightSize] [decimal](28, 8) NULL
	END
END


--[ĐÌnh Hoà] Create New [25/08/2021] bổ sung cột LipSize
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2121' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2121' AND col.name = 'LipSize')
	BEGIN
    ALTER TABLE SOT2121 ADD [LipSize] [decimal](28, 8) NULL
	END
END



