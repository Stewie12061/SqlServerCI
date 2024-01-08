-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified by Tiểu Mai on 19/01/2016: Bổ sung columns IsPlanPrice
---- Modified by Tra Giang  on 19/10/2018: Bổ sung hàng bán đồng giá columns IsSimilar, UnitPrice cho ATTOM
---- Modified by Tra Giang on 11/02/2019: Bổ sung đối tượng (Customize =105 : LIENQUAN)
---- Modified by Đức thông on 20/11/2020: Bổ sung các trường phục vụ duyệt bảng giá (Customize =105 : LIENQUAN)
---- Modified by Lê Hoàng on 30/10/2020: Thêm trường Thiết lập tỷ lệ tính huê hồng nhân viên, và 5 trường mapping tỷ lệ tính huê hồng nhân viên theo gắn theo mã phân tích nào
---- Modified by Kiều Nga on 20/12/2021: Thêm trường IsConfirm
---- Modified by Thanh Lượng on 28/06/2023: Bổ sung thêm trường liên quan đến "duyệt".
---- Modified by Thanh Lượng on 14/07/2023: [2023/07/IS/0145] - Bổ sung thêm trường IsInheritCost(Bảng tính giá vốn dự kiến).
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT1301]') AND type in (N'U'))
CREATE TABLE [dbo].[OT1301](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[ID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[OID] [nvarchar](50) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_OT1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT1_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT1301] ADD  CONSTRAINT [DF_OT1_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'TypeID')
           Alter Table  OT1301 Add TypeID tinyint Null Default(0)
End 
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'CurrencyID')
           Alter Table  OT1301 Add CurrencyID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'InheritID')
           Alter Table  OT1301 Add InheritID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsConvertedPrice')
           Alter Table  OT1301 Add IsConvertedPrice tinyint Null
END

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsPlanPrice')
           Alter Table  OT1301 Add IsPlanPrice tinyint Null
End

-- Danh - 2018/04/13 Thêm trường xử lý bảng giá trước/sau thuế
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsTaxIncluded')
           Alter Table  OT1301 Add IsTaxIncluded tinyint Null DEFAULT (0)
END

-- Huỳnh Thử - 2020/04/08 Thêm trường mặt hàng theo bảng giá 
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsInventoryToPrice')
           Alter Table  OT1301 Add IsInventoryToPrice tinyint Null DEFAULT (0)
End

-- Lê Hoàng - 2020/10/30 Thêm trường Thiết lập tỷ lệ tính huê hồng nhân viên
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsSetBonus')
           Alter Table  OT1301 Add IsSetBonus tinyint Null DEFAULT (0)
End

-- Lê Hoàng - 2020/10/30 Thêm trường 5 trường mapping tỷ lệ tính huê hồng nhân viên theo gắn theo mã phân tích nào
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'AnaType01')
           Alter Table  OT1301 Add AnaType01 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'AnaType02')
           Alter Table  OT1301 Add AnaType02 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'AnaType03')
           Alter Table  OT1301 Add AnaType03 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'AnaType04')
           Alter Table  OT1301 Add AnaType04 varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'AnaType05')
           Alter Table  OT1301 Add AnaType05 varchar(50) Null
End

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ConfDescription')
           Alter Table  OT1301 Add ConfDescription NVARCHAR(250) Null 
END

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsConfirm01')
           Alter Table  OT1301 Add IsConfirm01 tinyint Null Default(0)
END

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ConfDescription01')
           Alter Table  OT1301 Add ConfDescription01 NVARCHAR(250) Null 
END

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsConfirm02')
           Alter Table  OT1301 Add IsConfirm02 tinyint Null Default(0)
END

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ConfDescription02')
           Alter Table  OT1301 Add ConfDescription02 NVARCHAR(250) Null 
END

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsConfirm')
           Alter Table  OT1301 Add IsConfirm tinyint Null Default(0)
END


-- Tra Giang - 2018/10/11 Thêm trường xử lý hàng đồng giá
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsSimilar')
           Alter Table  OT1301 Add IsSimilar tinyint Null DEFAULT (0)
End

If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'UnitPrice')
           Alter Table  OT1301 Add UnitPrice DECIMAL(28,8) Null 
End
-- Tra Giang - 2019/02/11 Thêm trường đối tượng (Custor =105 LIENQUAN) 
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ObjectID')
           Alter Table  OT1301 Add ObjectID NVARCHAR(50) Null 
End

-- Kiều Nga - 2019/09/16 Thêm trường bảng giá linh kiện / dịch vụ (Custor =108 NHANNGOC) 
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsServicePriceID')
           Alter Table  OT1301 Add IsServicePriceID tinyint Null DEFAULT (0)
End

---- ---- Modified by Đức Thông on 18/11/2020: Bổ sung trạng thái duyệt của bộ định mức theo qui cách (Dự án Liễn Quán)
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'PriceListStatus')
		Alter Table OT1301 Add PriceListStatus TINYINT NULL
END  

---- ---- Modified by Đức Thông on 20/11/2020: Bổ sung người duyệt của bộ định mức theo qui cách (Dự án Liễn Quán)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT1301' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ConfirmUserID')
		Alter Table OT1301 Add ConfirmUserID NVARCHAR(250) NULL
END  

---- ---- Modified by Đức Thông on 20/11/2020: Bổ sung ngày duyệt của bộ định mức theo qui cách (Dự án Liễn Quán)
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ConfirmDate')
		ALTER TABLE OT1301 Add ConfirmDate DATETIME NULL
END  

---- ---- Modified by Đức Thông on 20/11/2020: Bổ sung ý kiến duyệt của bộ định mức theo qui cách (Dự án Liễn Quán)
IF EXISTS (SELECT * FROM sysobjects WHERE Name = 'OT1301' and xtype ='U') 
BEGIN 
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ConfirmDescription')
		ALTER TABLE OT1301 ADD ConfirmDescription NVARCHAR(250) NULL
END
-- Người duyệt
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'Levels')
    Alter Table OT1301  ADD Levels INT NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'StatusSS')
    Alter Table OT1301 ADD StatusSS TinyInt NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT1301' AND col.name = 'ApprovingLevel')
    ALTER TABLE OT1301 ADD ApprovingLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT1301' AND col.name = 'ApproveLevel')
    ALTER TABLE OT1301 ADD ApproveLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT1301' AND col.name = 'APKMaster_9000')
	BEGIN
    ALTER TABLE OT1301 ADD APKMaster_9000 uniqueidentifier NULL
	END
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OT1301'  and col.name = 'ApprovalNotes')
	ALTER TABLE OT1301 ADD ApprovalNotes NVARCHAR(250) NULL

END
   --kế thừa bảng tính giá vốn dự kiến
If Exists (Select * From sysobjects Where name = 'OT1301' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1301'  and col.name = 'IsInheritCost')
           Alter Table  OT1301 Add IsInheritCost tinyint Null
End