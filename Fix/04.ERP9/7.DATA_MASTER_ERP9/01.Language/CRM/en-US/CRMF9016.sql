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
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9016'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9016';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.Address', @FormID, N'Address', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.Email', @FormID, N'Email', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.Mobile', @FormID, N'Mobile', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.ReceiverID', @FormID, N'Receiver ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.ReceiverName', @FormID, N'Receiver name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.RelatedToTypeName', @FormID, N'Related to object type', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.Tel', @FormID, N'Tel', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9016.Title', @FormID, N'Choose receiver', @LanguageID, NULL
