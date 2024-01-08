-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10001- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF10001';

SET @LanguageValue = N'List of standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard code';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name E';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type';
EXEC ERP9AddLanguage @ModuleID, 'QCF10001.TypeName', @FormID, @LanguageValue, @Language;

