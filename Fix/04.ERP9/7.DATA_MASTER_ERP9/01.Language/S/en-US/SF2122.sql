------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2122 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SF2122'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'S';
SET @FormID = 'SF2122';

EXEC ERP9AddLanguage @ModuleID, N'SF2122.Title', @FormID, N'View details email template', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.TemplateID', @FormID, N'Template ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.TemplateName', @FormID, N'Template name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.EmailTitle', @FormID, N'Title', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.EmailGroupID', @FormID, N'Group ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Disabled', @FormID, N'Disabled', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Tab01', @FormID, N'Email content', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Tab02', @FormID, N'Declare variable', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.MethodID', @FormID, N'Variable name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.ShowDescriptionID', @FormID, N'Content displayed', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Notification', @FormID, N'Notification', @LanguageID, NULL

EXEC ERP9AddLanguage @ModuleID, N'SF2122.EmailBody', @FormID, N'Email content', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.HTML', @FormID, N'Html', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Tab01', @FormID, N'Email template information', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Tab02', @FormID, N'Email template information', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Tab03', @FormID, N'Declare variable', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Tab04', @FormID, N'Email content', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SF2122.Text', @FormID, N'Text only', @LanguageID, NULL
