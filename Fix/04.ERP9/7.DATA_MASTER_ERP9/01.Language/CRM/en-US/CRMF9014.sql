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
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9014'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9014';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9014.Address', @FormID, N'Address', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9014.AssignedToUserID', @FormID, N'Assigned to', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9014.Email', @FormID, N'Email', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9014.LeadID', @FormID, N'Lead ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9014.LeadMobile', @FormID, N'Lead mobile', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9014.LeadName', @FormID, N'Lead name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9014.Title', @FormID, N'Choose lead', @LanguageID, NULL
