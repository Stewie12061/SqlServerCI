-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1410- CI
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
SET @FormID = 'CIF1410';

SET @LanguageValue = N'商品規格清單';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規格型號代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'规格类型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規格型號名稱（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.IsCommon', @FormID, @LanguageValue, @Language;

