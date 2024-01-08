-- <Summary>
---- Thông tin quản lý tồn kho của pallet
-- <History>
---- Create on 29/08/2019 by Khánh Đoan

---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT2003]') AND type in (N'U'))
CREATE TABLE [dbo].[WT2003](
		[APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
		[DivisionID]	VARCHAR(50)NOT NULL,
		[InventoryID]	NVARCHAR(50) NULL,
		[WareHouseID]	NVARCHAR(50) NULL,
		[ReVoucherID]	NVARCHAR(50) NULL,
		[ReTransactionID]NVARCHAR(50) NOT NULL,
		[ReVoucherDate]	DATETIME  NULL,
		[ReTranMonth]	INT  NULL,
		[ReTranYear]	INT NULL,
		[ReVoucherNo]	NVARCHAR(50) NULL,
		[ReSourceNo]	NVARCHAR(50) NULL,
		[LimitDate]		DATETIME  NULL,
		[ReQuantity]	DECIMAL(28,8) NULL,
		[DeQuantity]	DECIMAL(28,8) NULL,
		[EndQuantity]	DECIMAL(28,8) NULL,
		[IsOutStock]	TINYINT NULL, -- xuất hết kho
		[ExVoucherDate] DATETIME NULL--- ngày xuất kho
 CONSTRAINT [PK_WT2003] PRIMARY KEY NONCLUSTERED 
(	[APK],
	[ReTransactionID]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




