                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0024 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:18:11 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0024' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0024' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0024.ChooseVoucher', N'POSF0024', N'Select inventory slip', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.Title', N'POSF0024', N' Votes discrepancies category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.ToPeriod', N'POSF0024', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.ToDate', N'POSF0024', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.DescriptionFilter', N'POSF0024', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.DivisionID', N'POSF0024', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.ShopID', N'POSF0024', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.EmployeeID', N'POSF0024', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.VoucherDate', N'POSF0024', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.VoucherNo', N'POSF0024', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.EVoucherNo', N'POSF0024', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.EmployeeName', N'POSF0024', N'Bill creater name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.FromPeriod', N'POSF0024', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0024.FromDate', N'POSF0024', N'From date', N'en-US', NULL

