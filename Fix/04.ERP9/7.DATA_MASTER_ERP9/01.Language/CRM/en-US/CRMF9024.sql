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
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9024'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9024';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9024.AccountID', @FormID, N'Customer ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9024.AccountName', @FormID, N'Customer name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9024.Address', @FormID, N'Address', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9024.Email', @FormID, N'Email', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9024.Tel', @FormID, N'Tel', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9024.Title', @FormID, N'Choose Customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9024.VATNo', @FormID, N'VAT NO', @LanguageID, NULL
