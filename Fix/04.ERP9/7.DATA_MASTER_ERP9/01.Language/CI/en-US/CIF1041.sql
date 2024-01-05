------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1041 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1041'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1041';

EXEC ERP9AddLanguage @ModuleID, N'CIF1041.Title', @FormID, N'Email template', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.TemplateID', @FormID, N'Template ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.TemplateName', @FormID, N'Template name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.EmailTitle', @FormID, N'Title', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.EmailGroupID', @FormID, N'Group ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.Disabled', @FormID, N'Disabled', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.Tab01', @FormID, N'Email content', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.Tab02', @FormID, N'Declare variable', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.MethodID', @FormID, N'Variable name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.ShowDescriptionID', @FormID, N'Content displayed', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1041.Notification', @FormID, N'Notification', @LanguageID, NULL
