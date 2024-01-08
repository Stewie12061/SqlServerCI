-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1043- CI
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
SET @FormID = 'CIF1043';
SET @LanguageValue  = N'Choose email template'
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.IsCommonName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Template code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Template name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email groups';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email content';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailBody', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email groups';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.ScreenID', @FormID, @LanguageValue, @Language;

