                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0019 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:14:36 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0019' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0019' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0019.POSF00241Title', N'POSF0019', N'{0} diary', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.TitleA', N'POSF0019', N'Update the journal diary', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.ChooseVoucher', N'POSF0019', N'Select inventory slip', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.Title', N'POSF0019', N'Goods journal entries category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.ToPeriodFilter', N'POSF0019', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.ToDateFilter', N'POSF0019', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.DescriptionFilter', N'POSF0019', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.DivisionIDFilter', N'POSF0019', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.UnitPrice', N'POSF0019', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.Description1', N'POSF0019', N'Description 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.Description2', N'POSF0019', N'Description 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.Description3', N'POSF0019', N'Description 3', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.Description4', N'POSF0019', N'Description 4', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.Description5', N'POSF0019', N'Description 5', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.SalesQuantity', N'POSF0019', N'Sold goods', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.ErrorQuantity', N'POSF0019', N'Defective inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.MovingQuantity', N'POSF0019', N'Goods on the road', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.FromMovingQuantity', N'POSF0019', N'Commodities (to)', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.ToMovingQuantity', N'POSF0019', N'Commodities (from)', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.ShowCaseQuantity', N'POSF0019', N'Sample', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.ShopIDFilter', N'POSF0019', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.InventoryID', N'POSF0019', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.EmployeeID', N'POSF0019', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.VoucherDateFilter', N'POSF0019', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.VoucherNoFilter', N'POSF0019', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.StockQuantity', N'POSF0019', N'Stock quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.InventoryName', N'POSF0019', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.PreparedByFilter', N'POSF0019', N'Creater name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.FromPeriodFilter', N'POSF0019', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0019.FromDateFilter', N'POSF0019', N'From date', N'en-US', NULL

