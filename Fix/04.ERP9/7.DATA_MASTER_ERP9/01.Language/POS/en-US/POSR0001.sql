                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSR0001 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:39:17 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSR0001' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSR0001' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSR0001.TitleGTGT', N'POSR0001', N'(Exported value VAT invoice of the day)', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TitleVAT', N'POSR0001', N'(Price includes VAT)', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.GoodBye', N'POSR0001', N'THANK YOU, SEE YOU AGAIN.', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TotalDiscountAmount', N'POSR0001', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.ShopName', N'POSR0001', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Address', N'POSR0001', N'Address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.UnitPrice', N'POSR0001', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Tel', N'POSR0001', N'Tel', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.UnitName', N'POSR0001', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Email', N'POSR0001', N'Email', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Fax', N'POSR0001', N'Fax', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TotalRedureAmount', N'POSR0001', N'Sale off', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TitleCustomTMQ3', N'POSR0001', N'RETAIL BILL', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.PaymentObjectAmount01', N'POSR0001', N'Cash', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.MemberID', N'POSR0001', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.VATNo', N'POSR0001', N'VAT ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.VoucherDate', N'POSR0001', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.EmployeeName', N'POSR0001', N'Employee', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Title', N'POSR0001', N'BILL', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.PaymentID', N'POSR0001', N'Payment methods', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.VoucherNo', N'POSR0001', N'Bill NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.ActualQuantity', N'POSR0001', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Order', N'POSR0001', N'NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.InventoryName', N'POSR0001', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.MemberName', N'POSR0001', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.InventoryAmount', N'POSR0001', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TotalTaxAmount', N'POSR0001', N'VAT tax', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TotalAmount', N'POSR0001', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Change', N'POSR0001', N'Exchange money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TotalInventoryAmount', N'POSR0001', N'Total', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TotalActualQuantity', N'POSR0001', N'Total quantity inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.TotalAfterVatInventoryAmount', N'POSR0001', N'Total payment money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSR0001.Website', N'POSR0001', N'Website', N'en-US', NULL

