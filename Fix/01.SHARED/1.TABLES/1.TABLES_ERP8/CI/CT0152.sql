-- <Summary>
---- Bảng giá theo số lượng nhóm hàng
-- <History>
---- Create  on 01/11/2021 by Kiều Nga
---- Updated on 26/08/2022 by Văn Tài	-	InventoryID, AnaID: Mã mặt hàng và MPT cho MAITHU.
---- Updated on 11/11/2022 by Nhật Thanh: Bổ sung đánh dấu bảng giá cho thuê kho
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CT0152]') AND type in (N'U'))
CREATE TABLE [dbo].[CT0152](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[ID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[OID] [nvarchar](50) NULL,
	[InventoryID] [varchar](50) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[AnaID] [varchar](50) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_CT0152] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CT0152_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CT0152] ADD  CONSTRAINT [DF_CT0152_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'TypeID')
           Alter Table  CT0152 Add TypeID tinyint Null Default(0)
End 
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'CurrencyID')
           Alter Table  CT0152 Add CurrencyID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'InheritID')
           Alter Table  CT0152 Add InheritID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'IsConvertedPrice')
           Alter Table  CT0152 Add IsConvertedPrice tinyint Null
END

If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'IsPlanPrice')
           Alter Table  CT0152 Add IsPlanPrice tinyint Null
End

-- Danh - 2018/04/13 Thêm trường xử lý bảng giá trước/sau thuế
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'IsTaxIncluded')
           Alter Table  CT0152 Add IsTaxIncluded tinyint Null DEFAULT (0)
END

-- Huỳnh Thử - 2020/04/08 Thêm trường mặt hàng theo bảng giá 
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'IsInventoryToPrice')
           Alter Table  CT0152 Add IsInventoryToPrice tinyint Null DEFAULT (0)
End

-- Lê Hoàng - 2020/10/30 Thêm trường Thiết lập tỷ lệ tính huê hồng nhân viên
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'IsSetBonus')
           Alter Table  CT0152 Add IsSetBonus tinyint Null DEFAULT (0)
End

-- Lê Hoàng - 2020/10/30 Thêm trường 5 trường mapping tỷ lệ tính huê hồng nhân viên theo gắn theo mã phân tích nào
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'AnaType01')
           Alter Table  CT0152 Add AnaType01 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'AnaType02')
           Alter Table  CT0152 Add AnaType02 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'AnaType03')
           Alter Table  CT0152 Add AnaType03 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'AnaType04')
           Alter Table  CT0152 Add AnaType04 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'AnaType05')
           Alter Table  CT0152 Add AnaType05 varchar(50) Null
End

If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'IsSetBonus')
           Alter Table  CT0152 Add IsSetBonus tinyint Null DEFAULT (0)

		   -- Văn Tài - 26/08/2022 Mặt hàng và mã phân tích dành cho MAITHU
		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'InventoryID')
           Alter Table  CT0152 Add InventoryID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'AnaID')
           Alter Table  CT0152 Add AnaID VARCHAR(50) NULL
End

-- Nhật Thanh - 14/11/2022: Bổ sung đánh dấu bảng giá cho thuê kho
If Exists (Select * From sysobjects Where name = 'CT0152' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0152'  and col.name = 'IsWarehouseRental')
           Alter Table  CT0152 Add IsWarehouseRental tinyint Null DEFAULT (0)
End