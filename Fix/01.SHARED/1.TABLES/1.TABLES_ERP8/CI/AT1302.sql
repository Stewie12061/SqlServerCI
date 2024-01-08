﻿-- <Summary>
---- Danh mục mặt hàng
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified on 19/03/2015 by Lê Thị Hạnh: Thêm ETaxID và ETaxConvertedUnit - Thuế BVMT
---- Modified on 19/08/2015 by Trần Quốc Tuấn thêm ProductTypeID
---- Modified on 02/12/2015 by Phan thanh hoàng Vũ (CustomizeIndex = 43 (Secoin): Khi nhập bên Loại mặt hàng bên CI thì bắn qua Loại sản phẩm bên HRM)
---- Modify on 19/01/2016 by Thị Phượng: Bổ sung trường Theo dõi vỏ Customize Hoàng Trần (CustomizeIndex = 51)
---- Modify on 28/02/2016 by Bảo Anh: Bổ sung thêm 5 MPT mặt hàng
---- Modified by Quốc Tuấn on 10/06/2016: Bổ sung trường InventoryNameNoUnicode
---- Modified by Thị Phượng on 14/07/2017: Bổ sung trường IsNorm
---- Modified by Bảo Thy on 30/08/2017: Bổ sung trường IsExpense (chuẩn)
---- Modified by Hoàng Vũ on 11/04/2019: bổ sung check Phiếu quà tặng/voucher/Gift (Thư bổ sung theo bản dự án)
---- Modified by Bảo Thy on 20/01/2018: bổ sung check quản lý mặt hàng theo số serial (Module CS-ERP9.0) (Thư bổ sung theo bản dự án)
---- Modified by Văn Tài on 16/06/2020: Bổ sung các cột Notes4 từ DA.
---- Modified by Hương Nhung on 22/12/2023: Bổ sung trường Varchar11,Varchar12,Varchar13,Varchar14,Varchar15

---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1302]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1302](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[S1] [nvarchar](50) NULL,
	[S2] [nvarchar](50) NULL,
	[S3] [nvarchar](50) NULL,
	[InventoryName] [nvarchar](250) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Image01ID] [image] NULL,
	[Image02ID] [image] NULL,
	[Varchar01] [nvarchar](50) NULL,
	[Varchar02] [nvarchar](50) NULL,
	[Varchar03] [nvarchar](50) NULL,
	[Varchar04] [nvarchar](50) NULL,
	[Varchar05] [nvarchar](50) NULL,
	[Amount01] [decimal](28, 8) NULL,
	[Amount02] [decimal](28, 8) NULL,
	[Amount03] [decimal](28, 8) NULL,
	[Amount04] [decimal](28, 8) NULL,
	[Amount05] [decimal](28, 8) NULL,
	[SalePrice01] [decimal](28, 8) NULL,
	[SalePrice02] [decimal](28, 8) NULL,
	[SalePrice03] [decimal](28, 8) NULL,
	[SalePrice04] [decimal](28, 8) NULL,
	[SalePrice05] [decimal](28, 8) NULL,
	[PriceDate01] [datetime] NULL,
	[PriceDate02] [datetime] NULL,
	[PriceDate03] [datetime] NULL,
	[PriceDate04] [datetime] NULL,
	[PriceDate05] [datetime] NULL,
	[RecievedPrice] [decimal](28, 8) NULL,
	[DeliveryPrice] [decimal](28, 8) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[Classify01ID] [nvarchar](50) NULL,
	[Classify02ID] [nvarchar](50) NULL,
	[Classify03ID] [nvarchar](50) NULL,
	[Classify04ID] [nvarchar](50) NULL,
	[Classify05ID] [nvarchar](50) NULL,
	[Classify06ID] [nvarchar](50) NULL,
	[Classify07ID] [nvarchar](50) NULL,
	[Classify08ID] [nvarchar](50) NULL,
	[MethodID] [tinyint] NOT NULL,
	[IsSource] [tinyint] NOT NULL,
	[AccountID] [nvarchar](50) NULL,
	[SalesAccountID] [nvarchar](50) NULL,
	[PurchaseAccountID] [nvarchar](50) NULL,
	[PrimeCostAccountID] [nvarchar](50) NULL,
	[IsLimitDate] [tinyint] NOT NULL,
	[IsLocation] [tinyint] NOT NULL,
	[IsStocked] [tinyint] NOT NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[NormMethod] [tinyint] NOT NULL,
	[I01ID] [nvarchar](50) NULL,
	[I02ID] [nvarchar](50) NULL,
	[I03ID] [nvarchar](50) NULL,
	[I04ID] [nvarchar](50) NULL,
	[I05ID] [nvarchar](50) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[Notes03] [nvarchar](250) NULL,
	[IsTools] [tinyint] NOT NULL,
	[IsKIT] [tinyint] NOT NULL,
	[KITID] [nvarchar](50) NULL,
	[RefInventoryID] [nvarchar](50) NULL,
	[Specification] [nvarchar](250) NULL,
	[VATImGroupID] [nvarchar](50) NULL,
	[VATImPercent] [decimal](28, 8) NULL,
	[PurchasePrice01] [decimal](28, 8) NULL,
	[PurchasePrice02] [decimal](28, 8) NULL,
	[PurchasePrice03] [decimal](28, 8) NULL,
	[PurchasePrice04] [decimal](28, 8) NULL,
	[PurchasePrice05] [decimal](28, 8) NULL,
	[Barcode] [nvarchar](50) NULL,
	[IsDiscount] [tinyint] NOT NULL,
	[AutoSerial] [tinyint] NOT NULL,
	[SS1] [nvarchar](50) NULL,
	[SS2] [nvarchar](50) NULL,
	[SS3] [nvarchar](50) NULL,
	[OutputOrder] [tinyint] NULL,
	[OutputLength] [tinyint] NULL,
	[Separated] [tinyint] NOT NULL,
	[Separator] [nvarchar](5) NULL,
	[S1Type] [tinyint] NULL,
	[S2Type] [tinyint] NULL,
	[S3Type] [tinyint] NULL,
	[Enabled1] [tinyint] NULL,
	[Enabled2] [tinyint] NULL,
	[Enabled3] [tinyint] NULL,
 CONSTRAINT [PK_AT1302] PRIMARY KEY NONCLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_MethodID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_MethodID]  DEFAULT ((4)) FOR [MethodID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_IsLot]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_IsLot]  DEFAULT ((0)) FOR [IsSource]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_SalesAccountID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_SalesAccountID]  DEFAULT ((5111)) FOR [SalesAccountID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_PurchaseAccountID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_PurchaseAccountID]  DEFAULT ((1561)) FOR [PurchaseAccountID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_PrimeCostAccountID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_PrimeCostAccountID]  DEFAULT ((632)) FOR [PrimeCostAccountID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_IsLimitDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_IsLimitDate]  DEFAULT ((0)) FOR [IsLimitDate]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_IsLocation]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_IsLocation]  DEFAULT ((0)) FOR [IsLocation]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_IsStocked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_IsStocked]  DEFAULT ((1)) FOR [IsStocked]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_NormMethod]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_NormMethod]  DEFAULT ((0)) FOR [NormMethod]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1302_IsTools]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF_AT1302_IsTools]  DEFAULT ((0)) FOR [IsTools]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT1302__IsKIT__35CA4D07]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF__AT1302__IsKIT__35CA4D07]  DEFAULT ((0)) FOR [IsKIT]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT1302__IsDiscou__256DF289]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF__AT1302__IsDiscou__256DF289]  DEFAULT ((0)) FOR [IsDiscount]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT1302__AutoSeri__20225AE3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF__AT1302__AutoSeri__20225AE3]  DEFAULT ((0)) FOR [AutoSerial]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT1302__Separate__21167F1C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1302] ADD  CONSTRAINT [DF__AT1302__Separate__21167F1C]  DEFAULT ((0)) FOR [Separated]
END
---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='ETaxID')
		ALTER TABLE AT1302 ADD ETaxID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='ETaxConvertedUnit')
		ALTER TABLE AT1302 ADD ETaxConvertedUnit DECIMAL(28,8) DEFAULT 1 NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'ProductTypeID')
		ALTER TABLE AT1302 ADD ProductTypeID TINYINT NULL
	END
-- Modified on 25/05/2015 by Lê Thị Hạnh: Thêm NRTClassifyID, SETID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='NRTClassifyID')
		ALTER TABLE AT1302 ADD NRTClassifyID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='SETID')
		ALTER TABLE AT1302 ADD SETID NVARCHAR(50) NULL
	END
-- Tạo Column IsCommon By Thịnh : 25/08/2015
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsCommon')
    ALTER TABLE AT1302 ADD [IsCommon] [tinyint] NULL
END

---- Alter Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
 BEGIN
  IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
  ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='ETaxConvertedUnit')
  BEGIN
  EXEC DROPCONSTRAINT 'AT1302','ETaxConvertedUnit' 
  ALTER TABLE AT1302 ALTER COLUMN ETaxConvertedUnit DECIMAL(28,8) NULL 
  END
 END
 --CustomizeIndex = 43 (Secoin): Khi nhập bên Loại mặt hàng bên CI thì bắn qua Loại sản phẩm bên HRM
 IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsToHRM')
        ALTER TABLE AT1302 ADD IsToHRM TINYINT NULL
    END
--- Modify on 30/12/2015 by Bảo Anh: Bổ sung Tk doanh thu trả lại, Tồn kho an toàn, nội dung kiểm tra sản phẩm (Angel)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='ReSalesAccountID')
		ALTER TABLE AT1302 ADD ReSalesAccountID NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='IsMinQuantity')
		ALTER TABLE AT1302 ADD IsMinQuantity tinyint NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='QCList')
		ALTER TABLE AT1302 ADD QCList NVARCHAR(4000) NULL
	END
--- Modify on 19/01/2016 by Thị Phượng: Bổ sung trường Theo dõi vỏ Customize Hoàng Trần (CustomizeIndex = 51)

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsBottle')
        ALTER TABLE AT1302 ADD IsBottle TINYINT NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='I06ID')
		ALTER TABLE AT1302 ADD I06ID NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='I07ID')
		ALTER TABLE AT1302 ADD I07ID NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='I08ID')
		ALTER TABLE AT1302 ADD I08ID NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='I09ID')
		ALTER TABLE AT1302 ADD I09ID NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='I10ID')
		ALTER TABLE AT1302 ADD I10ID NVARCHAR(50) NULL
		
		-- Thêm trường này bổ sung tìm kiếm tên không dấu
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'InventoryNameNoUnicode')
        ALTER TABLE AT1302 ADD InventoryNameNoUnicode VARCHAR(250) NULL
	END
	--Bổ sung IsNorm cho danh mục mặt hàng trên ERP 9.0
		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='IsNorm')
			ALTER TABLE AT1302 ADD IsNorm TINYINT DEFAULT 0 NULL
		END


---- Modified by Bảo Thy on 30/08/2017: Bổ sung trường IsExpense (chuẩn)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsExpense') 
   ALTER TABLE AT1302 ADD IsExpense TINYINT NULL 
END
---Modified by Thị Phượng on 07/12/2017: Bổ sung trường Mã hàng metro và quản lý thẻ VIP
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'MetroInventoryID') 
   ALTER TABLE AT1302 ADD MetroInventoryID VARCHAR(50) NULL 
END
/*===============================================END MetroInventoryID===============================================*/ 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsVIP') 
   ALTER TABLE AT1302 ADD IsVIP TINYINT NULL 
END
/*===============================================END IsVIP===============================================*/ 

---Modified by Bảo Thy on 20/01/2018: bổ sung check quản lý mặt hàng theo số serial (Module CS-ERP9.0)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsSerialized') 
   ALTER TABLE AT1302 ADD IsSerialized TINYINT NULL 
END

---Modified by Hoàng Vũ on 11/04/2019: bổ sung check Phiếu quà tặng/voucher/Gift
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsGiftVoucher') 
   ALTER TABLE AT1302 ADD IsGiftVoucher TINYINT NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'IsSafeSpecifications') 
   ALTER TABLE AT1302 ADD IsSafeSpecifications TINYINT NULL 
END


---- Modified by Trà Giang on 09/03/2020: Bổ sung trường Varchar06, Notes04 , Notes05 (Lưu thông tin vị trí xếp kho, rế, động cơ cho Tân Hòa Lợi = Customer 122)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
	BEGIN		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Notes04')
		ALTER TABLE AT1302 ADD Notes04 NVARCHAR(250) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Notes05')
		ALTER TABLE AT1302 ADD Notes05 NVARCHAR(250) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Varchar06')
		ALTER TABLE AT1302 ADD Varchar06 NVARCHAR(50) NULL		
	END

---- Modified by Lê Hoàng on 13/04/2020: Tăng kích thước trường Ghi chú và tham số
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1302' AND xtype='U')
BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Notes01')
		ALTER TABLE AT1302 ALTER COLUMN Notes01 NVARCHAR(MAX) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Notes02')
		ALTER TABLE AT1302 ALTER COLUMN Notes02 NVARCHAR(MAX) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Notes03')
		ALTER TABLE AT1302 ALTER COLUMN Notes03 NVARCHAR(MAX) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Notes04')
		ALTER TABLE AT1302 ALTER COLUMN Notes04 NVARCHAR(MAX) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Notes05')
		ALTER TABLE AT1302 ALTER COLUMN Notes05 NVARCHAR(MAX) NULL
		
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Varchar01')
		ALTER TABLE AT1302 ALTER COLUMN Varchar01 NVARCHAR(500) NULL	

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Varchar02')
		ALTER TABLE AT1302 ALTER COLUMN Varchar02 NVARCHAR(500) NULL	

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Varchar03')
		ALTER TABLE AT1302 ALTER COLUMN Varchar03 NVARCHAR(500) NULL	

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Varchar04')
		ALTER TABLE AT1302 ALTER COLUMN Varchar04 NVARCHAR(500) NULL	

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Varchar05')
		ALTER TABLE AT1302 ALTER COLUMN Varchar05 NVARCHAR(500) NULL	

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1302' AND col.name='Varchar06')
		ALTER TABLE AT1302 ALTER COLUMN Varchar06 NVARCHAR(500) NULL	
END

---- Modified by Kiều Nga on 10/08/2020: Tăng kích thước trường thông tin kỹ thuật
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Specification') 
   ALTER TABLE AT1302 ALTER COLUMN Specification NVARCHAR(MAX) NULL
END

---- Modified by Kiều Nga on 22/12/2021: Bổ sung AssemblyRank
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'AssemblyRank') 
   ALTER TABLE AT1302 ADD AssemblyRank DECIMAL(28,8) NULL
END

--  Modified by Hồng Thắm on 06/12/2023: Bổ sung trường Varchar06,Varchar07,Varchar08,Varchar09,Varchar10
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar06')
    ALTER TABLE AT1302 ADD Varchar06 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar07')
    ALTER TABLE AT1302 ADD Varchar07 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar08')
    ALTER TABLE AT1302 ADD Varchar08 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar09')
    ALTER TABLE AT1302 ADD Varchar09 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar10')
    ALTER TABLE AT1302 ADD Varchar10 NVARCHAR(500) NULL
END

--  Modified by Hương Nhung on 22/12/2023: Bổ sung trường Varchar11,Varchar12,Varchar13,Varchar14,Varchar15
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar11')
    ALTER TABLE AT1302 ADD Varchar11 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar12')
    ALTER TABLE AT1302 ADD Varchar12 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar13')
    ALTER TABLE AT1302 ADD Varchar13 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar14')
    ALTER TABLE AT1302 ADD Varchar14 NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1302' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1302' AND col.name = 'Varchar15')
    ALTER TABLE AT1302 ADD Varchar15 NVARCHAR(500) NULL
END