-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10010- QC
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
SET @FormID = 'QCF10010';

SET @LanguageValue = N'Danh mục Tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard code';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name E';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type';
EXEC ERP9AddLanguage @ModuleID, 'QCF10010.TypeName', @FormID, @LanguageValue, @Language;

