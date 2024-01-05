
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ LMF2061- OO
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
SET @ModuleID = 'LM';
SET @FormID = 'LMF2061';

SET @LanguageValue = N'Cập nhật giải chấp tài sản';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng vay';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.LoanVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hiệu lực đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.LoanConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài sản';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.AssetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài sản';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.AssetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị sổ sách';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.AccountingValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị thẩm định';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.EvaluationValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Hạn mức';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.LoanLimitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giải chấp';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.UnwindDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị hạn mức';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.LoanLimitAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị đã thế chấp';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.MortgageAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị còn lại';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.RemainAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị giải chấp';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.UnwindAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'LMF2061.Attach', @FormID, @LanguageValue, @Language;
