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
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9015'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9015';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.AssignedToUserID', @FormID, N'Assigned to', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.DeadlineRequest', @FormID, N'Deadline request', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.RequestDescription', @FormID, N'Request description', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.RequestStatus', @FormID, N'Request status', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.RequestSubject', @FormID, N'Request subject', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.TimeRequest', @FormID, N'Time request', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.Title', @FormID, N'Choose request', @LanguageID, NULL

-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.RequestCustomerID', @FormID, N'Request CustomerID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.ProjectName', @FormID, N'Project Name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9015.TypeOfRequest', @FormID, N'Type Of Request', @LanguageID, NULL