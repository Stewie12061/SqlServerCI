-- <Summary>
---- 
-- <History>
---- Create on 13/08/2010 by Việt Khánh
---- Modified on 09/06/2014 by Le Thi Thu Hien
---- Modified on 25/06/2014 by Lê Thị Hạnh: Bổ sung trường cho checkbox cảnh báo tồn kho
---- Modified on 24/02/2015 by Phan thanh hoàng Vũ: Bổ sung trường cho checkbox [Phân quyền xem dữ liệu của người khác]
---- Modified on 14/09/2015 by Nguyễn Thanh Thịnh: Bổ Sung Thêm trường Loại Chứng từ Điều Chỉnh Tăng Và Điều CHỉnh Giảm
---- Modified on 17/12/2015 by Phan thanh hoàng Vũ: CustomizeIndex = 56 (TMDVQ3): Bổ sung chức năng tắt /mở duyệt phiếu yêu cầu
---- Modified on 17/12/2015 by Phương Thảo: Bổ sung thiết lập tự động sinh phiếu điều chỉnh khi làm kiểm kê
---- Modified by Tiểu Mai on 09/08/2016: Bổ sung thiết lập duyệt phiếu yêu cầu nhập xuất vcnb 2 cấp
---- Modified by Kim Thư on 11/12/2018: Bổ sung InvoiceSign và Serial lưu thông tin hóa đơn điện tử từ phiếu VCNB (CustomerIndex = 16 - Siêu Thanh)
---- Modified by Văn Tài on 10/09/2020: Bổ sung cột từ 8.3.7 DA sang.
---- Modified by Nhật Thanh on 26/10/2023: Bổ sung cột TransportWareHouseID
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT0000]') AND type in (N'U'))
CREATE TABLE [dbo].[WT0000](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DefDivisionID] [nvarchar](3) NULL,
	[DefTranMonth] [int] NULL,
	[DefTranYear] [int] NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[IsNegativeStock] [tinyint] NOT NULL,
	[PaymentTermID] [nvarchar](50) NULL,
	[IsAsoftM] [tinyint] NOT NULL,
	[IsAsoftHRM] [tinyint] NOT NULL,
	[IsAsoftOP] [tinyint] NOT NULL,
	[PrimeCostAccountID] [nvarchar](50) NULL,
	[IsAutoSourceNo] [tinyint] NOT NULL,
	[IsCalUnitPrice] [tinyint] NOT NULL,
	[IsBarcode] [tinyint] NOT NULL,
	[IsConvertUnit] [tinyint] NOT NULL,
	CONSTRAINT [PK_WT0000] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_WT0000_IsNegativeStock]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF_WT0000_IsNegativeStock]  DEFAULT ((0)) FOR [IsNegativeStock]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__WT0000__IsAsoftM__3668A02E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF__WT0000__IsAsoftM__3668A02E]  DEFAULT ((0)) FOR [IsAsoftM]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__WT0000__IsAsoftH__375CC467]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF__WT0000__IsAsoftH__375CC467]  DEFAULT ((0)) FOR [IsAsoftHRM]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__WT0000__IsAsoftO__3850E8A0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF__WT0000__IsAsoftO__3850E8A0]  DEFAULT ((0)) FOR [IsAsoftOP]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__WT0000__IsAutoSo__092A807F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF__WT0000__IsAutoSo__092A807F]  DEFAULT ((0)) FOR [IsAutoSourceNo]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__WT0000__IsCalUni__2B37E1C5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF__WT0000__IsCalUni__2B37E1C5]  DEFAULT ((0)) FOR [IsCalUnitPrice]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_WT0000_IsBarCode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF_WT0000_IsBarCode]  DEFAULT ((0)) FOR [IsBarcode]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__WT0000__IsConver__095338CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WT0000] ADD  CONSTRAINT [DF__WT0000__IsConver__095338CD]  DEFAULT ((0)) FOR [IsConvertUnit]
END
---- Add Columns
-- Thêm cột IsCheckPOQuantity vào bảng WT0000
IF(ISNULL(COL_LENGTH('WT0000', 'IsCheckPOQuantity'), 0) <= 0)
ALTER TABLE WT0000 ADD IsCheckPOQuantity tinyint NULL
-- Thêm cột IsAutoCreateVoucher vào bảng WT0000
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='IsAutoCreateVoucher')
		ALTER TABLE WT0000 ADD IsAutoCreateVoucher TINYINT DEFAULT(0) NULL
	END
If Exists (Select * From sysobjects Where name = 'WT0000' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0000'  and col.name = 'IsAutoDiffVoucher')
           Alter Table  WT0000 Add IsAutoDiffVoucher tinyint Null
End 
If Exists (Select * From sysobjects Where name = 'WT0000' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0000'  and col.name = 'DiffVoucherTypeID')
           Alter Table  WT0000 Add DiffVoucherTypeID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'WT0000' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0000'  and col.name = 'IsEditInherit')
           Alter Table  WT0000 Add IsEditInherit tinyint Null
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='IsWarnWareHouse')
		ALTER TABLE WT0000 ADD IsWarnWareHouse TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='IsPermissionView')
		ALTER TABLE WT0000 ADD IsPermissionView TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='VoucherNoIncre')
		ALTER TABLE WT0000 ADD VoucherNoIncre [nvarchar](50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='VoucherNoDecs')
		ALTER TABLE WT0000 ADD VoucherNoDecs [nvarchar](50) NULL
	END
--CustomizeIndex = 56 (TMDVQ3): Bổ sung chức năng tắt /mở duyệt phiếu yêu cầu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0000' AND col.name = 'IsConfirm')
        ALTER TABLE WT0000 ADD IsConfirm TINYINT NULL
    END	

---- Modified on 17/12/2015 by Phương Thảo: Bổ sung thiết lập tự động sinh phiếu điều chỉnh khi làm kiểm kê
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0000' AND col.name = 'IsAutoCrAdjustVoucher')
        ALTER TABLE WT0000 ADD IsAutoCrAdjustVoucher TINYINT NULL
    END
    
---- Modified by Tiểu Mai on 09/08/2016: Bổ sung thiết lập duyệt phiếu yêu cầu nhập xuất vcnb 2 cấp
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0000' AND col.name = 'IsConfirmRequire')
        ALTER TABLE WT0000 ADD IsConfirmRequire TINYINT DEFAULT(0)
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='CorAccountIDAsc')
		ALTER TABLE WT0000 ADD CorAccountIDAsc [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='CorAccountIDDesc')
		ALTER TABLE WT0000 ADD CorAccountIDDesc [nvarchar](50) NULL
	END

---- Modified by Bảo Thy on 17/02/2017: Bổ sung cảnh báo tồn kho an toàn (EIMSKIP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0000' AND col.name = 'IsSafeInventory') 
   ALTER TABLE WT0000 ADD IsSafeInventory TINYINT NULL 
END
---- Modified by Tấn Phú on 29/08/2017: Bổ sung trường bị thiếu so với database chuẩn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='IsCreateExVoucher')
		ALTER TABLE WT0000 ADD IsCreateExVoucher TINYINT NULL
	END

---- Modified by Kim Thư on 11/12/2018: Bổ sung InvoiceSign và Serial lưu thông tin hóa đơn điện tử từ phiếu VCNB (CustomerIndex = 16 - Siêu Thanh)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='InvoiceSign')
	ALTER TABLE WT0000 ADD InvoiceSign VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='Serial')
	ALTER TABLE WT0000 ADD Serial VARCHAR(50) NULL
END

---- Modified by Văn Tài on 10/09/2020: Bổ sung trường bị thiếu so với database chuẩn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0000' AND col.name='IsAutoConfirmRequire')
		ALTER TABLE WT0000 ADD IsAutoConfirmRequire TINYINT NULL
	END
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0000' AND col.name = 'TransportWareHouseID') 
   ALTER TABLE WT0000 ADD TransportWareHouseID VARCHAR(50) NULL 
END