------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2021 - CRM
--            Ngày tạo                                    Người tạo
--            07/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9025'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9025';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.ContactID', @FormID, N'Contact ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.ContactName', @FormID, N'Contact name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.Disabled', @FormID, N'Disabled', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.HomeAddress', @FormID, N'Home address', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.HomeEmail', @FormID, N'Home email', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.HomeMobile', @FormID, N'Home mobile', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.HomeTel', @FormID, N'Home tel', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9025.Title', @FormID, N'Choose contact', @LanguageID, NULL
