---------------------------Sửa trường PaymentID -> APKPaymentID-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentID')
	EXEC sp_rename 'dbo.POST9000.PaymentID', 'APKPaymentID', 'COLUMN';
END

---------------------------Sửa kiểu dữ liệu Varchar -> Unidientify-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='APKPaymentID')
	Alter Table POST9000
		Alter column APKPaymentID uniqueidentifier;
END

---------------------------Xóa Tên phương thức thanh toán-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentName')
	ALTER TABLE POST9000 Drop Column PaymentName
END
---------------------------Sửa trường PaymentObjectID -> PaymentObjectID01-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectID')
	EXEC sp_rename 'dbo.POST9000.PaymentObjectID', 'PaymentObjectID01', 'COLUMN';
END

---------------------------Sửa trường PaymentObjectName -> PaymentObjectName01-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectName')
	EXEC sp_rename 'dbo.POST9000.PaymentObjectName', 'PaymentObjectName01', 'COLUMN';
END

----------------------------ID thanh toán 02 {2} = ID--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectID02')
	ALTER TABLE POST9000 ADD PaymentObjectID02 varchar(50) NULL ;
END
---------------------------Xóa DROPCONSTRAINT-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
       IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
       ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectID02')
       BEGIN
              EXEC DROPCONSTRAINT 'POST9000', 'PaymentObjectID02'             
       END
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectID02')
	Alter Table POST9000
		Alter column PaymentObjectID02 varchar(50) NULL ;
END

----------------------------Name thanh toán 02 {2} = Name--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectName02')
	ALTER TABLE POST9000 ADD PaymentObjectName02 nvarchar(250) NULL ;
END
---------------------------Xóa DROPCONSTRAINT-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
       IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
       ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectName02')
       BEGIN
              EXEC DROPCONSTRAINT 'POST9000', 'PaymentObjectName02'             
       END
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectName02')
	Alter Table POST9000
		Alter column PaymentObjectName02 nvarchar(250) NULL ;
END
----------------------------{Tiền hàng}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='TotalAmount')
	ALTER TABLE POST9000 ADD TotalAmount Decimal(28,6) DEFAULT (0) NULL
END
----------------------------{Tiền thuế}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='TotalTaxAmount')
	ALTER TABLE POST9000 ADD TotalTaxAmount Decimal(28,6) DEFAULT (0) NULL
END
----------------------------{%Chiêt khấu}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='TotalDiscountRate')
	ALTER TABLE POST9000 ADD TotalDiscountRate Decimal(28,6) DEFAULT (0) NULL
END
----------------------------{Tiền Chiêt khấu}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='TotalDiscountAmount')
	ALTER TABLE POST9000 ADD TotalDiscountAmount Decimal(28,6) DEFAULT (0) NULL
END
----------------------------{%Giảm giá}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='TotalRedureRate')
	ALTER TABLE POST9000 ADD TotalRedureRate Decimal(28,6) DEFAULT (0) NULL
END
----------------------------{Tiền Giảm giá}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='TotalRedureAmount')
	ALTER TABLE POST9000 ADD TotalRedureAmount Decimal(28,6) DEFAULT (0) NULL
END
----------------------------{Tổng tiền}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='TotalInventoryAmount')
	ALTER TABLE POST9000 ADD TotalInventoryAmount Decimal(28,6) DEFAULT (0) NULL
END
----------------------------Tiền Thanh toán 01 {3}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectAmount01')
	ALTER TABLE POST9000 ADD PaymentObjectAmount01 Decimal(28,6) DEFAULT (0) NULL
END
----------------------------Tiền Thanh toán 02 {4}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PaymentObjectAmount02')
	ALTER TABLE POST9000 ADD PaymentObjectAmount02 Decimal(28,6) DEFAULT (0) NULL
END
----------------------------Tiền thừa--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='Change')
	ALTER TABLE POST9000 ADD Change Decimal(28,6) DEFAULT (0) NULL
END
----------------------------Thêm {Số tài khoản ngân hàng 01}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='AccountNumber01')
	ALTER TABLE POST9000 ADD AccountNumber01 nvarchar(250) DEFAULT NULL
END

----------------------------Thêm {Số tài khoản ngân hàng 02}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='AccountNumber02')
	ALTER TABLE POST9000 ADD AccountNumber02 nvarchar(250) DEFAULT NULL
END
----------------------------Thêm {Đã kết kết chuyển}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='IsTransferred')
	ALTER TABLE POST9000 ADD IsTransferred Tinyint NULL
END

----------------Customer KingCom--Thêm {PVoucherNo: Số chứng từ trả hàng}-----------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='PVoucherNo')
	ALTER TABLE POST9000 ADD PVoucherNo varchar(50) NULL
END

----------------Customer KingCom--Thêm {CVoucherNo: Số chứng từ đổi hàng}-----------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='CVoucherNo')
	ALTER TABLE POST9000 ADD CVoucherNo varchar(50) NULL
END

----------------------------Thêm Customer-KINGCOM{ChangeAmount:Chênh lệch đổi hàng}--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='ChangeAmount')
	ALTER TABLE POST9000 ADD ChangeAmount Decimal(28,6) DEFAULT (0) NULL
END

----------------Customer Kingcom--Thêm {IsKindVoucherID: dùng để biết trạng thái mặt hàng cần đổi và mặt hàng được ----------------------------------------đổi: 0: Phiếu xuất; 1: Phiếu nhập}-----------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='IsKindVoucherID')
	ALTER TABLE POST9000 ADD IsKindVoucherID int NULL default 0
END
 
----------------Customer Kingcom--Thêm {IsPromotion: Set null}-----------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='IsPromotion')
	ALTER TABLE POST9000 ALTER COLUMN IsPromotion tinyint NULL
END 

----------------Thêm diễn giải {Description: Set null}-----------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST9000' AND xtype='U')
BEGIN
	IF not EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST9000' AND col.name='Description')
	ALTER TABLE POST9000 ADD Description nvarchar(250) NULL
END 

--Customize theo MINHSANG: CA tính thưởng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'CA')
   ALTER TABLE POST9000 ADD CA DECIMAL(28,8) NULL
END
--Customize theo MINHSANG: CAAmount tính lương
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'CAAmount')
   ALTER TABLE POST9000 ADD CAAmount DECIMAL(28,8) NULL
END
--Giao hàng hay chưa giao hàng (đã sinh phiếu xuất hay chưa sinh phiếu xuất)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsWarehouseExported')
   ALTER TABLE POST9000 ADD IsWarehouseExported TINYINT NULL
END
--Customize theo MINHSANG: Chênh lệch hàng khuyến mãi
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'PromoteChangeAmount')
   ALTER TABLE POST9000 ADD PromoteChangeAmount DECIMAL(28,8) NULL
END
--Nhân viên bán hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'SaleManID')
   ALTER TABLE POST9000 ADD SaleManID VARCHAR(50) NULL
END
--Customize theo MINHSANG: Chênh lệch hàng khuyến mãi chi tiết
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'PromoteChangeUnitPrice')
   ALTER TABLE POST9000 ADD PromoteChangeUnitPrice DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsInstallmentPrice')
   ALTER TABLE POST9000 ADD IsInstallmentPrice TINYINT NULL
END

/*===============================================END IsInstallmentPrice===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'APPSuggestID')
   ALTER TABLE POST9000 ADD APPSuggestID UNIQUEIDENTIFIER NULL
END

/*===============================================END APPSuggestID===============================================*/ 

----------Thêm trường [Kho tổng giao] hay [Trả tại công ty] hay [Đổi tại công ty]-----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsWarehouseGeneral') 
   ALTER TABLE POST9000 ADD IsWarehouseGeneral TINYINT NULL 
END
/*===============================================END IsWarehouseGeneral===============================================*/

----------Thêm trường [Xuất ngay] ----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsExportNow') 
   ALTER TABLE POST9000 ADD IsExportNow TINYINT NULL 
END
/*===============================================END IsExportNow===============================================*/

----------Thêm trường [Số Series] --CustomizeIndex = 87 OKIA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'SerialNo') 
   ALTER TABLE POST9000 ADD SerialNo VARCHAR(50) NULL 
END
/*===============================================END SerialNo===============================================*/ 

--Thêm trường [Tiền đặt cọc]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'BookingAmount') 
   ALTER TABLE POST9000 ADD BookingAmount DECIMAL(28,8) NULL 
END
/*===============================================END BookingAmount===============================================*/

--Bảng giá bán theo gói
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'PackagePriceID') 
   ALTER TABLE POST9000 ADD PackagePriceID VARCHAR(50) NULL 
END
/*===============================================END PackagePriceID===============================================*/ 

--Là mặt hàng theo gói
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsPackage') 
   ALTER TABLE POST9000 ADD IsPackage TINYINT NULL 
END
/*===============================================END IsPackage===============================================*/

--Gói sản phẩm trong bảng giá bán
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'PackageID') 
   ALTER TABLE POST9000 ADD PackageID VARCHAR(50) NULL 
END
/*===============================================END PackageID===============================================*/ 

--Thêm trường [Địa chỉ giao hàng]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'DeliveryAddress') 
   ALTER TABLE POST9000 ADD DeliveryAddress NVARCHAR(250) NULL 
END
/*===============================================END DeliveryAddress===============================================*/ 

--Thêm trường [Người liên hệ]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'DeliveryContact') 
   ALTER TABLE POST9000 ADD DeliveryContact NVARCHAR(250) NULL 
END
/*===============================================END DeliveryContact===============================================*/ 

--Thêm trường [Điện thoại]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'DeliveryMobile') 
   ALTER TABLE POST9000 ADD DeliveryMobile NVARCHAR(250) NULL 
END
/*===============================================END DeliveryMobile===============================================*/ 

--Thêm trường [Người nhận hàng]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'DeliveryReceiver') 
   ALTER TABLE POST9000 ADD DeliveryReceiver NVARCHAR(250) NULL 
END
/*===============================================END DeliveryReceiver===============================================*/ 

--Là mặt hàng kế thừa từ phiếu đặt cọc
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsBooking') 
   ALTER TABLE POST9000 ADD IsBooking TINYINT NULL 
END
/*===============================================END IsBooking===============================================*/ 

-- Hoàng Vũ Date 08/03/2018 Là mặt hàng Khuyến mãi tăng hàng theo hóa đơn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsInvoicePromotionID') 
   ALTER TABLE POST9000 ADD IsInvoicePromotionID TINYINT NULL 
END
/*===============================================END IsInvoicePromotionID===============================================*/ 

--Modified by Hoàng vũ Date: 18/04/2018: Bổ sung trường phân biệt Bảng giá trước thuế hay sau thuế (1: sau thuế; 0: trước thuế)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsTaxIncluded') 
   ALTER TABLE POST9000 ADD IsTaxIncluded TINYINT NULL 
END

/*===============================================END IsTaxIncluded===============================================*/ 

--Modified by Hoàng vũ Date: 18/04/2018: Nếu bảng giá sau thì lấy chiết khấu tính lại để ra đơn giá trước chiết khấu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'BeforeVATDiscountAmount') 
   ALTER TABLE POST9000 ADD BeforeVATDiscountAmount DECIMAL(28,8) NULL 
END

/*===============================================END BeforeVATDiscountAmount===============================================*/

--Modified by Hoàng vũ Date: 18/04/2018: Nếu bảng giá sau thì lấy đơn giá tính lại để ra đơn giá trước thuế
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'BeforeVATUnitPrice') 
   ALTER TABLE POST9000 ADD BeforeVATUnitPrice DECIMAL(28,8) NULL 
END

/*===============================================END BeforeVATUnitPrice===============================================*/ 

--Quản lý bán hàng theo gói sản phẩm (1 gói sản phẩm có thể khai báo 1 mặt hàng nhiều lần): lưu vết để truy xuất ngược gói để lấy giá, thuế.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'APKPackageInventoryID') 
   ALTER TABLE POST9000 ADD APKPackageInventoryID UNIQUEIDENTIFIER NULL 
END
/*===============================================END APKPackageInventoryID===============================================*/ 
---Modified by Tra Giang on 02/08/2018: Thêm trường check chọn giá sỉ IsWholesale
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsWholesale') 
   ALTER TABLE POST9000 ADD IsWholesale TINYINT  NULL 
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'DiscountAllocation') 
   ALTER TABLE POST9000 ADD DiscountAllocation DECIMAL(28,8) NULL 
END

/*===============================================END DiscountAllocation===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'DiscountOneUnitOfProduct') 
   ALTER TABLE POST9000 ADD DiscountOneUnitOfProduct DECIMAL(28,8) NULL 
END

/*===============================================END DiscountOneUnitOfProduct===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'RedureAllocation') 
   ALTER TABLE POST9000 ADD RedureAllocation DECIMAL(28,8) NULL 
END

/*===============================================END RedureAllocation===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'RedureOneUnitOfProduct') 
   ALTER TABLE POST9000 ADD RedureOneUnitOfProduct DECIMAL(28,8) NULL 
END

/*===============================================END RedureOneUnitOfProduct===============================================*/ 

--Quan lý việc có sự dụng phiếu quà tặng cho hóa đơn này hay không (Làm trước cho Khách hàng NHÂN NGỌC)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'IsGiftVoucherUsed') 
   ALTER TABLE POST9000 ADD IsGiftVoucherUsed TINYINT NULL 
END
/*===============================================END IsGiftVoucherUsed===============================================*/ 

--Quan lý việc có sự dụng phiếu quà tặng cho hóa đơn này hay không nếu có thì tính tổng tiền qua tặng(Làm trước cho Khách hàng NHÂN NGỌC)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'TotalGiftVoucherAmount') 
   ALTER TABLE POST9000 ADD TotalGiftVoucherAmount DECIMAL(28,8) NULL 
END
/*===============================================END TotalGiftVoucherAmount===============================================*/ 

--Lưu vết [Giá tối thiểu] của bảng giá bán dưới ERP8 => VUONGSACH và NHANNGOC dùng trường này để ghi diểm/tính hoa dòng theo nhân viên bàn hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'MinPrice') 
   ALTER TABLE POST9000 ADD MinPrice DECIMAL(28,8) NULL 
END
/*===============================================END MinPrice===============================================*/ 

--Lưu vết [Ghi chú 1] của bảng giá bán dưới ERP8 => NHANNGOC dùng trường này để ghi diểm/tính hoa hồng theo Điểm nhân viên giao hảng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'Notes01') 
   ALTER TABLE POST9000 ADD Notes01 NVARCHAR(250) NULL 
END
/*===============================================END Notes01===============================================*/

--Lưu vết [Ghi chú 2] của bảng giá bán dưới ERP8 => NHANNGOC dùng trường này để ghi diểm/tính hoa hồng theo Điểm nhân viên kho
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'Notes02') 
   ALTER TABLE POST9000 ADD Notes02 NVARCHAR(250) NULL 
END
/*===============================================END Notes02===============================================*/ 

--Lưu vết [Ghi chú 3] của bảng giá bán dưới ERP8 => NHANNGOC dùng trường này để ghi diểm/tính hoa hồng theo Điểm nhân viên thu ngân
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'Notes03') 
   ALTER TABLE POST9000 ADD Notes03 NVARCHAR(250) NULL 
END
/*===============================================END Notes03===============================================*/ 

--Lưu vết [Ghi chú 4] của bảng giá bán dưới ERP8 => NHANNGOC dùng trường này để ghi diểm/tính hoa hồng theo Điểm nhân viên phụ kho
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'Notes04') 
   ALTER TABLE POST9000 ADD Notes04 NVARCHAR(250) NULL 
END
/*===============================================END Notes04===============================================*/ 

--Lưu vết đơn giá bán (Phục vụ trường hợp: nếu phiếu bán hàng co check vào giá trả góp thì sau khi lưu edit phiếu bỏ check giá trả góp thì hệ thống không load lại giá bán gốc ban đầu của mặt hàng)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'RefUnitPrice') 
   ALTER TABLE POST9000 ADD RefUnitPrice DECIMAL(28,8) NULL 
END
/*===============================================END RefUnitPrice===============================================*/ 

--Lưu vết đơn giá bán trả góp (Phục vụ trường hợp: nếu phiếu bán hàng co check vào giá trả góp thì sau khi lưu edit phiếu bỏ check giá trả góp thì hệ thống không load lại giá bán gốc ban đầu của mặt hàng)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST9000' AND col.name = 'InstallmentPrice') 
   ALTER TABLE POST9000 ADD InstallmentPrice DECIMAL(28,8) NULL 
END
/*===============================================END InstallmentPrice===============================================*/ 