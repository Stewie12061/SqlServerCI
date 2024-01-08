------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2110 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2110';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceOriginal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ lợi nhuận mong muốn(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận mong muốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitDesired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá đối thủ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceRival' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.SetNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.StatusSS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ColorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.Address' , @FormID, @LanguageValue, @Language;