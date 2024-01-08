-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1541- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1541';

SET @LanguageValue = N'成本公式之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公有程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定義';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'食譜';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.IsUsed', @FormID, @LanguageValue, @Language;

