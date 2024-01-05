-- <Summary> Danh mục thiết lập chương trình khuyến mãi theo điều kiện ( Chi tiết điều kiện_con) (Detail 2)
-- <History>
---- Create on 19/04/2023 by Lê Thanh Lượng 
---- Modified on 24/11/2023 by Hoàng Long - [2023/11/TA/0160] - Customize loại chiết khấu thiết lập trong detail 2 chương trình khuyến mãi
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1222]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1222](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[ConditionID] VARCHAR(50) NULL, -- Mã Điều kiện
	[Level] NVARCHAR(50) NULL,
	[PaymentMethod] NVARCHAR(250) NULL, -- Mã cách  trả chiết khấu
	[Target] NVARCHAR(50) NULL, 
	[UnitID] NVARCHAR(50) NULL, -- Mã đơn vị
	[UnitName] NVARCHAR(50) NULL, -- Tên đơn vị
	[InventoryGiftID] VARCHAR(50) NULL, -- Mã quà tặng
	[InventoryGiftName] VARCHAR(50) NULL,
	[Value] DECIMAL(28,8) , -- Giá trị
	[ReturnGifeDate] DATETIME NULL, -- Ngày trả quà
	[PromotionID] NVARCHAR(50) NULL, -- Mã loại chiết khấu
	[PromotionName] NVARCHAR(250) NULL,
	[Notes] NVARCHAR(500) NULL, -- GHI CHÚ
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
 CONSTRAINT [PK_CIT1222] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'Orders')
    Alter Table CIT1222 ADD Orders INT NULL
END
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'InventoryGiftQuantity')
    Alter Table CIT1222 ADD InventoryGiftQuantity INT NULL
END

If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'TargetType')
    Alter Table CIT1222 ADD TargetType NVARCHAR(50) NULL
END
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'TargetQuantity')
    Alter Table CIT1222 ADD TargetQuantity DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'Spendinglevel')
    Alter Table CIT1222 ADD Spendinglevel DECIMAL(28,8) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'ToTargetQuantity')
    Alter Table CIT1222 ADD ToTargetQuantity DECIMAL(28,8) NULL
END

--Bổ sung cột công cụ - Sử dụng cho khách NKC
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'ToolIDCIT1222')
    Alter Table CIT1222 ADD ToolIDCIT1222 NVARCHAR(50) NULL
END
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'AccumulatedGrowUpValue')
    Alter Table CIT1222 ADD AccumulatedGrowUpValue Decimal(18,8) NULL
END
--Bổ sung cột Thời gian tích lũy từ ngày
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'AccumulationFromDate')
    Alter Table CIT1222 ADD AccumulationFromDate DATETIME NULL
END
--Bổ sung cột Thời gian tích lũy đến ngày
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'AccumulationToDate')
    Alter Table CIT1222 ADD AccumulationToDate DATETIME NULL
END
--Bổ sung cột Áp dụng lũy kế - NKC
If Exists (Select * From sysobjects Where name = 'CIT1222' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1222'  and col.name = 'IsAccumulated')
    Alter Table CIT1222 ADD IsAccumulated TINYINT NULL
END

