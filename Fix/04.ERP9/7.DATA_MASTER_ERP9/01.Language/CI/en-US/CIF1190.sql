﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1190- CI
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
SET @Language = 'en-US'; 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1190';
SET @LanguageValue  = N'Categories type currencies'
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Operator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal part';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.ExchangeRateDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal part name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.DecimalName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit part name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pricing method';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Method', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.CreateUserID', @FormID, @LanguageValue, @Language;

