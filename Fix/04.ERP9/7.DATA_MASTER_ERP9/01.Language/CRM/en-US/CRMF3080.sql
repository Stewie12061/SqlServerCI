------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000 - CRM
--            Ngày tạo                                    Người tạo
--            2/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF3080'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF3080';

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.FromAccountName', @FormID, N'From customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.FromEmployeeID', @FormID, N'From employee', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.Title', @FormID, N'Report customer request', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.ToAccountName', @FormID, N'To customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.ToEmployeeID', @FormID, N'To employee', @LanguageID, NULL
