-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1092- CI
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
SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1092';

EXEC ERP9AddLanguage @ModuleID, N'CIF1092.Title', @FormID, N'View details type of object increase automatically', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.TypeID', @FormID, N'Type of object', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.ThongMaPhanTich', @FormID, N'Information classification code', @Language, NULL
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.DivisionID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.STypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.SName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unusual type View';
EXEC ERP9AddLanguage @ModuleID, 'CIF1092.APK', @FormID, @LanguageValue, @Language;

