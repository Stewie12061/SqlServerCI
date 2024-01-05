------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2115 - CRM 
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
SET @FormID = 'SOF2115';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Kế thừa bảng tính giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceOriginal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ lợi nhuận mong muốn(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ProfitRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận mong muốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ProfitDesired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceSetFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceAcreageFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceSetInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceAcreageInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá đối thủ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceRival' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.DivisionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.DivisionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.StatusSS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ColorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.SetNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.Address' , @FormID, @LanguageValue, @Language;
