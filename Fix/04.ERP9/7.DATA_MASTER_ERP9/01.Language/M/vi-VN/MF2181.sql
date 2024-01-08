-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2181- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2181';

SET @LanguageValue = N'Cập nhật yêu cầu đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.VoucherDate ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng dưới xưởng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InventoryFactoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tem nhãn hiệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.BranchTem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Nest Code';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.NestCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ hàng/thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set/thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Total', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu hộp đựng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Colors', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng màu';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.NumberColor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Branch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cuối ship hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CancelDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.StandardName.CB', @FormID, @LanguageValue, @Language;