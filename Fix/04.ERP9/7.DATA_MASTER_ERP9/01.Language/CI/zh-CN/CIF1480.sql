-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1480- CI
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
SET @FormID = 'CIF1480';

SET @LanguageValue = N'買賣分析代碼之设立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定義';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定義（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.SystemNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.IsUsed', @FormID, @LanguageValue, @Language;

