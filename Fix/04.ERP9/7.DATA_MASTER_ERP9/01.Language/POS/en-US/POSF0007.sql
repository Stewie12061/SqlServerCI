                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0007 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:04:57 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0007' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0007' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0007.IsNegativeStock', N'POSF0007', N'Allow output warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.WarehouseID', N'POSF0007', N'Select company warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.WarehouseName', N'POSF0007', N'Select company warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.DivisionID', N'POSF0007', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.MonthYear', N'POSF0007', N'Accounting period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.PaymentID01', N'POSF0007', N'Payment methods 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.PageSize', N'POSF0007', N'Number of lines per page', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.Title', N'POSF0007', N'General setup', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.IsConnectERP', N'POSF0007', N'Is connect ERP', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0007.IsInstallmentPrice', N'POSF0007', N'Installment payment', N'en-US', NULL

