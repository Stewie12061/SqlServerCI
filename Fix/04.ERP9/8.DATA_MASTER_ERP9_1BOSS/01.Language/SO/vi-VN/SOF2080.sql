-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2080- SO
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
SET @FormID = 'SOF2080';

SET @LanguageValue = N'Danh mục thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.DeliveryTime', @FormID, @LanguageValue, @Language;

