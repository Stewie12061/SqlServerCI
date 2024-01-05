-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1363- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1363';

SET @LanguageValue = N'Cập nhật thông tin chọn hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ObjectID', @FormID, @LanguageValue, @Language;