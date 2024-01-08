-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2093';

SET @LanguageValue = N'Ngày xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ExportVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bán hàng/đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bán hàng/đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lần bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.NumberOfWarranty', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu xuất hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.SaleVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.FromShopID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ShopID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ShopName.CB', @FormID, @LanguageValue, @Language;



