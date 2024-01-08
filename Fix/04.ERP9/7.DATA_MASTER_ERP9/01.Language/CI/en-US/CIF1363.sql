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
SET @Language = 'en-US' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1363';

SET @LanguageValue = N'Enter search conditions';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some contracts';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract signing date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original currency contract value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted contract value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'CIF1363.Description', @FormID, @LanguageValue, @Language;

