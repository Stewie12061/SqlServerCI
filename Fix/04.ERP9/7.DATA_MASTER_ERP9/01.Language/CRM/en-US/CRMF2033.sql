------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2033 - CRM
--            Ngày tạo                                    Người tạo
--            29/01/20121								  Đình hòa
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2033';

EXEC ERP9AddLanguage @ModuleID, N'CRMF2033.Title', @FormID, N'Description', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF2033.AssignedToUserID', @FormID, N'Assigned To User', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF2033.AssignedToUsername', @FormID, N'Assigned To User', @LanguageID, NULL

