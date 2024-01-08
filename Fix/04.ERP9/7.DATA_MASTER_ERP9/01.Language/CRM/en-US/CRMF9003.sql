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
-- SELECT * FROM A00001 WHERE FormID = 'CMNF9003'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CMNF9003';

EXEC ERP9AddLanguage @ModuleID, N'CMNF9003.Address', @FormID, N'Address', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9003.DepartmentName', @FormID, N'Department name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9003.Email', @FormID, N'Email', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9003.EmployeeID', @FormID, N'Employee ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9003.EmployeeName', @FormID, N'Employee name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9003.Tel', @FormID, N'Tel', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9003.Title', @FormID, N'Choose employee', @LanguageID, NULL