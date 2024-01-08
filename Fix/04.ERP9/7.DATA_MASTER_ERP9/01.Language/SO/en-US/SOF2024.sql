------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2024 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SOF2024'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2024';

EXEC ERP9AddLanguage @ModuleID, N'SOF2024.Description', @FormID, N'Description', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.EmployeeID', @FormID, N'Employee', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.IsConfirm', @FormID, N'Confirm', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.ObjectName', @FormID, N'Object name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.QuotationDate', @FormID, N'Quotation date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.QuotationNo', @FormID, N'Quotation NO', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.QuotationStatus', @FormID, N'Quotation Status', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.SumAmount', @FormID, N'Sum amount', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF2024.Title', @FormID, N'Choose quotation', @LanguageID, NULL