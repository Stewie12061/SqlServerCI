-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1220- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1220';

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Created user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Created date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of zones';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.Title', @FormID, @LanguageValue, @Language;

