-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1411- CI
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
SET @FormID = 'CIF1411';

SET @LanguageValue = N'商品規格清單';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規格型號代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'规格类型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規格型號名稱（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1411.IsCommon', @FormID, @LanguageValue, @Language;

