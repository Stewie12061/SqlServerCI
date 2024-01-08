------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000 - CRM
--            Ngày tạo                                    Người tạo
--            07/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CMNF9005'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = '00';
SET @FormID = 'CMNF9005';

EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.Title', @FormID, N'Send email', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.AssignedToUserID', @FormID, N'Assigned to user', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.CreateDate', @FormID, N'Create date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.CreateUserID', @FormID, N'Create user', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.EmailSubject', @FormID, N'Email subject', @LanguageID, NULL

-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.SubjectName', @FormID, N'Subject Name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.From', @FormID, N'From', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.To', @FormID, N'To', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.Cc', @FormID, N'Cc', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.Bcc', @FormID, N'Bcc', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9005.StatusName', @FormID, N'Status Name', @LanguageID, NULL