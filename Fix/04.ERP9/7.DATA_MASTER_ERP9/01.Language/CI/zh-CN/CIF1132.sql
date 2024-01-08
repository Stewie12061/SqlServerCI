-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1132- CI
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
SET @FormID = 'CIF1432';

SET @LanguageValue = N'項目類型詳細信息之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品類型名稱（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.APK', @FormID, @LanguageValue, @Language;

