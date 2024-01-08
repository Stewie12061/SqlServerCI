                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0037 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:25:27 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0037' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0037' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0037.ShopID', N'POSF0037', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.ToPeriod', N'POSF0037', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.ToDate', N'POSF0037', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.DivisionID', N'POSF0037', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.EmployeeID', N'POSF0037', N'Employee', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.PaymentID', N'POSF0037', N'Payment methods', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.Title', N'POSF0037', N'Consolidate sales by employee', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.FromPeriod', N'POSF0037', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0037.FromDate', N'POSF0037', N'From date', N'en-US', NULL

