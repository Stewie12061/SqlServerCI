-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10006- QC
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
SET @FormID = 'QCF10006';

SET @LanguageValue = N'List of standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard Name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type name ';
EXEC ERP9AddLanguage @ModuleID, 'QCF10006.TypeName', @FormID, @LanguageValue, @Language;

