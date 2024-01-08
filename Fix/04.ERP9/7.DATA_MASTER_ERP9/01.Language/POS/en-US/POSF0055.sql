                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0055 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:32:20 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0055' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0055' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0055.Description', N'POSF0055', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0055.EmployeeID', N'POSF0055', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0055.VoucherDate', N'POSF0055', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0055.Title', N'POSF0055', N'Enter the inventory balance information', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0055.VoucherNo', N'POSF0055', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0055.EmployeeName', N'POSF0055', N'Creater name', N'en-US', NULL

