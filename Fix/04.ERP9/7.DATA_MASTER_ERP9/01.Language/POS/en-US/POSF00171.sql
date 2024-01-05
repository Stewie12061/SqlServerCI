                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00171 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:14:03 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00171' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00171' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00171.TitleUpdate', N'POSF00171', N'Updated inventory coupons', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.AdjustQuantity', N'POSF00171', N'Difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.Description', N'POSF00171', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.UnitID', N'POSF00171', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.InventoryID', N'POSF00171', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.EmployeeID', N'POSF00171', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.VoucherDate', N'POSF00171', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.IntentoryOrBardcode', N'POSF00171', N'Enter inventory code / Scan bar code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.ActualQuantity', N'POSF00171', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.BooksQuantity', N'POSF00171', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.VoucherNo', N'POSF00171', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.InventoryName', N'POSF00171', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.EmployeeName', N'POSF00171', N'Creater name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00171.Title', N'POSF00171', N'Add checklist', N'en-US', NULL

