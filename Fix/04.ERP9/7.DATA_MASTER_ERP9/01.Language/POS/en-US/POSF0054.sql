                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0054 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:32:00 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0054' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0054' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0054.Title', N'POSF0054', N'Inventory balances category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.Description', N'POSF0054', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.DivisionID', N'POSF0054', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.ShopID', N'POSF0054', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.EmployeeID', N'POSF0054', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.TranYear', N'POSF0054', N'Year', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.VoucherDate', N'POSF0054', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.VoucherNo', N'POSF0054', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0054.EmployeeName', N'POSF0054', N'Creater name', N'en-US', NULL

