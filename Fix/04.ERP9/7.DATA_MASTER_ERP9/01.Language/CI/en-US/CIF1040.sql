------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1040 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1040'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1040';

EXEC ERP9AddLanguage @ModuleID, N'CIF1040.Title', @FormID, N'Email template', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1040.TemplateID', @FormID, N'Template ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1040.TemplateName', @FormID, N'Template name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1040.EmailTitle', @FormID, N'Title', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1040.EmailGroupID', @FormID, N'Group ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1040.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1040.Disabled', @FormID, N'Disabled', @LanguageID, NULL
