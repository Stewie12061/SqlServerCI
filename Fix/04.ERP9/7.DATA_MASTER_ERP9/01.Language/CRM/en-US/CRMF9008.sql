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
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9008'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9008';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9008.CampaignID', @FormID, N'Campaign ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9008.CampaignName', @FormID, N'Campaign name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9008.CampaignStatus', @FormID, N'Campaign status', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9008.ExpectCloseDate', @FormID, N'Expect close date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9008.ExpectedRevenue', @FormID, N'Expected revenue', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9008.Title', @FormID, N'Choose campaign', @LanguageID, NULL
