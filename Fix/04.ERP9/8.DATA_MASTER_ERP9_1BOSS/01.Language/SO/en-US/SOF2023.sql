------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2023 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SOF2023'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2023';

EXEC ERP9AddLanguage @ModuleID, N'SOF2023.Description', @FormID, N'Description', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.EmployeeID', @FormID, N'Employee', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.EndDate', @FormID, N'Ending date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.ObjectID', @FormID, N'Object ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.ObjectName', @FormID, N'Object name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.OpportunityID', @FormID, N'Opportunity ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.QuotationDate', @FormID, N'Quotation date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.QuotationNo', @FormID, N'Quotation NO', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2023.Title', @FormID, N'Inerhit', @LanguageID, NULL