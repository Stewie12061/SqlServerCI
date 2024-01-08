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
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9010'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9010';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9010.Description', @FormID, N'Description', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9010.EventEndDate', @FormID, N'Event ending date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9010.EventStartDate', @FormID, N'Event starting date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9010.EventSubject', @FormID, N'Event subject', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9010.Title', @FormID, N'Choose event', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9010.TypeActive', @FormID, N'Type active', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9010.TypeID', @FormID, N'Type ID', @LanguageID, NULL
