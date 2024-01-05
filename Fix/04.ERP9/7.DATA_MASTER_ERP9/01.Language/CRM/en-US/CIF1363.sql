-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1363- CRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'CRM';
SET @FormID = 'CIF1363';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sign Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange Rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original Currency Value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted Value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ObjectID', @FormID, @LanguageValue, @Language;