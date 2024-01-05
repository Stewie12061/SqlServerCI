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
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9013'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9013';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.AssignedToUserID', @FormID, N'Assigned to', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.ExpectAmount', @FormID, N'Expect amount', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.ExpectedCloseDate', @FormID, N'Expected closed date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.NextActionID', @FormID, N'Next action', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.OpportunityID', @FormID, N'Opportunity ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.OpportunityName', @FormID, N'Opportunity name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.SourceID', @FormID, N'Source', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.StageID', @FormID, N'Stage', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.StartDate', @FormID, N'Starting date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9013.Title', @FormID, N'Choose opportunity', @LanguageID, NULL
