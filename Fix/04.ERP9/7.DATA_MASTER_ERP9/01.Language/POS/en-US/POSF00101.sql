                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00101 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:06:09 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00101' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00101' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00101.AppDiscount', N'POSF00101', N'Apply', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.PriceTable', N'POSF00101', N'Selling ​​under the general price list', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.PromotePriceTable', N'POSF00101', N'Selling at promotional price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Price', N'POSF00101', N'Sell ​​by price column', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.PriceTableColumn', N'POSF00101', N'Price list', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.TableAll', N'POSF00101', N'General price list', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.TableTime', N'POSF00101', N'Price list by time', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Title', N'POSF00101', N'Update store', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.IsPromote', N'POSF00101', N'Promotion policy', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.IsDiscount', N'POSF00101', N'Promotion by row', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.InvoicePromotionID', N'POSF00101', N'Promotional promotion by invoice', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Selected', N'POSF00101', N'Select', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ComWareHouseName', N'POSF00101', N'Select company warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.WareHouseName', N'POSF00101', N'Select store warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.TableInfo', N'POSF00101', N'Select a price list type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.PriceColumn', N'POSF00101', N'Price column', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.NNNS', N'POSF00101', N'Form of display', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.AutoIndex', N'POSF00101', N'Reset auto increment indicator', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Separator', N'POSF00101', N'Separator', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Address', N'POSF00101', N'Address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Email', N'POSF00101', N'Email address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Length', N'POSF00101', N'Length of membership code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DivisionID', N'POSF00101', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.SalePrices', N'POSF00101', N'Default price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.IPPrinter', N'POSF00101', N'IP printer', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Disabled', N'POSF00101', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.IsDiscount1', N'POSF00101', N'Promotion gifts', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.IsDiscount2', N'POSF00101', N'Promotion by invoice', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Logo', N'POSF00101', N'Shop logo', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ShopID', N'POSF00101', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ObjectID', N'POSF00101', N'Customer ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.WareHouseID', N'POSF00101', N'Warehouse ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.EmployeeID', N'POSF00101', N'User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.InventoryTypeID', N'POSF00101', N'Inventory type ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DefaultPrinter1', N'POSF00101', N'Food printer', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DefaultPrinter', N'POSF00101', N'Order printer', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DefaultPrinter2', N'POSF00101', N'Drinks printer', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.PlaceHolder', N'POSF00101', N'Enter the code / customer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.isS1', N'POSF00101', N'Analysis 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.isS2', N'POSF00101', N'Analysis 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.isS3', N'POSF00101', N'Analysis 3', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.InventoryTypeID1', N'POSF00101', N'Inventory type 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.InventoryType', N'POSF00101', N'Inventory type 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.InventoryTypeID2', N'POSF00101', N'Inventory type 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Tel', N'POSF00101', N'Tel', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Fax', N'POSF00101', N'Fax', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.TaxCreditAccount', N'POSF00101', N'Credit account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.TaxDebitAccount', N'POSF00101', N'Debit account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.IsAutomatic', N'POSF00101', N'Generate auto incremental code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ShopName', N'POSF00101', N'Shop name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DivisionName', N'POSF00101', N'Division name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ImageName', N'POSF00101', N'Image name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ObjectName', N'POSF00101', N'Customer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.EmployeeName', N'POSF00101', N'User name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ShortName', N'POSF00101', N'Short name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.TitleInsert', N'POSF00101', N'Insert shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.CommonInfo', N'POSF00101', N'Shop info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ProductInfo', N'POSF00101', N'Inventory info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.BillInfo', N'POSF00101', N'Order info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.VoucherNoInfo', N'POSF00101', N'Member ID info increases automatically', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.UserInfo', N'POSF00101', N'User info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.CostBillInfo', N'POSF00101', N'Costs account info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DebitInfo2', N'POSF00101', N'Order account info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DebitInfo', N'POSF00101', N'Tax account info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.PayBillInfo', N'POSF00101', N'Pay bill info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Example', N'POSF00101', N'Example', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Website', N'POSF00101', N'Website', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.BusinessArea', N'POSF00101', N'Business sector', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.PromoteIDCA', N'POSF00101', N'CA gift promotion', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.IsUsedCA', N'POSF00101', N'Apply', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.DisplayWareHouseID', N'POSF00101', N'Showroom', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.BrokenWareHouseID', N'POSF00101', N'Warehouse damaged', N'en-US', NULL

EXEC ERP9AddLanguage N'POS', N'POSF00101.FromDate', N'POSF00101', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.ToDate', N'POSF00101', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00101.Manager', N'POSF00101', N'List manager', N'en-US', NULL

