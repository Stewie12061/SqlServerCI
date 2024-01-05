                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0025 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:18:33 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0025' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0025' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0025.Detail', N'POSF0025', N'Detail', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.LastModifyDate', N'POSF0025', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.EvoucherNo', N'POSF0025', N'Inheritance reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.Description', N'POSF0025', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.UnitName', N'POSF0025', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.VoucherTypeID', N'POSF0025', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.InventoryID', N'POSF0025', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.VoucherDate', N'POSF0025', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.CreateDate', N'POSF0025', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.EmployeeName', N'POSF0025', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.LastModifyUserID', N'POSF0025', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.CreateUserID', N'POSF0025', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.VoucherNo', N'POSF0025', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.DisparityQuantity', N'POSF0025', N'Disparity quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.InventoryName', N'POSF0025', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.Title', N'POSF0025', N'Discrepancy info form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.SystemInfo', N'POSF0025', N'System info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0025.VoucherInfo', N'POSF0025', N'Voucher info', N'en-US', NULL

