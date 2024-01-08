-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2114- SO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2114';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目名稱 (ENG)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.TypeName', @FormID, @LanguageValue, @Language;

