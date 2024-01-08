-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1832- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF1832';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group code';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group name';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material Type';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ingredient Code';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialName_Temp', @FormID, @LanguageValue, @Language;

