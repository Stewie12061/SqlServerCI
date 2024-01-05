------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2121 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SF2121'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'S';
SET @FormID = 'SF2121';

EXEC ERP9AddLanguage @ModuleID, N'SF2121.Title', @FormID, N'Email template', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.TemplateID', @FormID, N'Template ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.TemplateName', @FormID, N'Template name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.EmailTitle', @FormID, N'Title', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.EmailGroupID', @FormID, N'Group ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.Disabled', @FormID, N'Disabled', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.Tab01', @FormID, N'Email content', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.Tab02', @FormID, N'Declare variable', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.MethodID', @FormID, N'Variable name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.ShowDescriptionID', @FormID, N'Content displayed', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2121.Notification', @FormID, N'Notification', @LanguageID, NULL
