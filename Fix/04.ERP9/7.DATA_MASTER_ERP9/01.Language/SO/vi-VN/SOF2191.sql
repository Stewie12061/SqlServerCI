-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2191- SO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2191';

SET @LanguageValue = N'Quản lý bảo hành sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2191.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số xe'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.CarNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ObjectType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ đối tượng bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Address2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số seri';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.SeriNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Phone' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.MVoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ExWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Long' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Weight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.High' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu sắc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.Color' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.WarrantyPeriod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ItemCondition' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhập mã QR';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.QRCode' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ProductionOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ObjectID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.ObjectName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.InventoryID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.InventoryName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.WarrantyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.WarrantyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.WareHouseID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.WareHouseName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2191.StandardName.CB' , @FormID, @LanguageValue, @Language;