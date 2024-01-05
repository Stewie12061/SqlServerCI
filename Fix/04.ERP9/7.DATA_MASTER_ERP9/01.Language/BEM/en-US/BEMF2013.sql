-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2013 - BEM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham số gen tự động
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

------------------------------------------------------------------------------------------------------
-- Gán giá trị tham số và thực thi truy vấn
------------------------------------------------------------------------------------------------------
/*
    - Tiếng Việt: vi-VN 
    - Tiếng Anh: en-US 
    - Tiếng Nhật: ja-JP
    - Tiếng Trung: zh-CN
*/

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2013';

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fee ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Journeys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remaining amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher bussiness trip ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTrip', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.ConvertedAmount', @FormID, @LanguageValue, @Language;
