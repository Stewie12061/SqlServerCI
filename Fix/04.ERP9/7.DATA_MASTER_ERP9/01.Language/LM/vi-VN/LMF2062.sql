
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ LMF2062- OO
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
SET @FormID = 'LMF2062';

SET @LanguageValue = N'Xem chi tiết giải chấp tài sản';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng vay';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.LoanVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hiệu lực đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giải chấp';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.UnwindDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.LoanConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài sản';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.AssetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài sản';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.AssetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị sổ sách';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.AccountingValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị thẩm định';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.EvaluationValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Hạn mức';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.LoanLimitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị hạn mức';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.LoanLimitAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị đã thế chấp';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.MortgageAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị còn lại';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.RemainAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị giải chấp';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.UnwindAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.SubTitle1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài sản thế chấp';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.SubTitle2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'LMF2062.LastModifyDate', @FormID, @LanguageValue, @Language;