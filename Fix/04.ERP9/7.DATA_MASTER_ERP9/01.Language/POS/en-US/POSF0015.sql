                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0015 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:10:30 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0015' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0015' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0015.POSF00151Title', N'POSF0015', N'{0} import bills', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.ChooseVoucher', N'POSF0015', N'Choose coupon', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.Title', N'POSF0015', N'Receipts category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.ToPeriod', N'POSF0015', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.ToPeriodFilter', N'POSF0015', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.ToDate', N'POSF0015', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.ToDateFilter', N'POSF0015', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.Description', N'POSF0015', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.DivisionID', N'POSF0015', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.UnitID', N'POSF0015', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.ShopID', N'POSF0015', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.InventoryID', N'POSF0015', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.EmployeeID', N'POSF0015', N'Receiver ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.VoucherDate', N'POSF0015', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.VoucherNo', N'POSF0015', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.RefVoucherNoFilter', N'POSF0015', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.MarkQuantity', N'POSF0015', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.ActualQuantity', N'POSF0015', N'Receive quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.InventoryName', N'POSF0015', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.DelivererName', N'POSF0015', N'Diliverer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.EmployeeName', N'POSF0015', N'Receiver name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.Status', N'POSF0015', N'Status', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.FromPeriod', N'POSF0015', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.FromPeriodFilter', N'POSF0015', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.FromDate', N'POSF0015', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0015.FromDateFilter', N'POSF0015', N'From date', N'en-US', NULL

