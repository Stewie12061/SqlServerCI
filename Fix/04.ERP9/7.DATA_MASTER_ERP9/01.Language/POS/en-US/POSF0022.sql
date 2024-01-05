                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0022 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:17:15 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0022' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0022' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0022.POSF00221Title', N'POSF0022', N'{0} export bills', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.Title', N'POSF0022', N'Updated the votes suggest exporting/return', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.Uneven', N'POSF0022', N'Difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.IsRefund', N'POSF0022', N'Choose export', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.ToPeriodFilter', N'POSF0022', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.ToDateFilter', N'POSF0022', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.DescriptionFilter', N'POSF0022', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.Description', N'POSF0022', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.IsExportShop', N'POSF0022', N'Shipping through the shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.DivisionIDFilter', N'POSF0022', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.UnitID', N'POSF0022', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.InventoryID', N'POSF0022', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.EmployeeIDFilter', N'POSF0022', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.VoucherDateFilter', N'POSF0022', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.PreparedByFilter', N'POSF0022', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.IntentoryOrBardcodeFilter', N'POSF0022', N'Enter inventory code / Scan bar code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.VoucherNoFilter', N'POSF0022', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.StockQuantity', N'POSF0022', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.CheckQuantity', N'POSF0022', N'Check quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.InventoryName', N'POSF0022', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.EmployeeNameFilter', N'POSF0022', N'Bill creater name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.RecipientNameFilter', N'POSF0022', N'Receiver name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.FromPeriodFilter', N'POSF0022', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.FromDateFilter', N'POSF0022', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.IsExportCompany', N'POSF0022', N'Return goods to the company', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0022.StatusInventory', N'POSF0022', N'Status', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', 'POSF0022.BtnExportTemplate' , N'POSF0022', N'Download template', N'en-US'
EXEC ERP9AddLanguage N'POS', 'POSF0022.ChooseFile' , N'POSF0022', N'Import inventories', N'en-US';

