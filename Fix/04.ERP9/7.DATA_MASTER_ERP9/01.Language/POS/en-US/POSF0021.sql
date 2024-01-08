                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0021 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:16:41 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0021' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0021' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0021.POSF00211Title', N'POSF0021', N'{0} offer request / return', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.ChooseVoucher', N'POSF0021', N'Choose coupon', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.Title', N'POSF0021', N'Category of receipts / returns', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.ToPeriodFilter', N'POSF0021', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.ToDateFilter', N'POSF0021', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.Description', N'POSF0021', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.DescriptionFilter', N'POSF0021', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.DivisionID', N'POSF0021', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.UnitID', N'POSF0021', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.ShopID', N'POSF0021', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.InventoryID', N'POSF0021', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.EmployeeID', N'POSF0021', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.ReceiverIDFilter', N'POSF0021', N'Receiver ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.VoucherDate', N'POSF0021', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.VoucherDateFilter', N'POSF0021', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.RecipientName', N'POSF0021', N'Receiver user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.RecipientShop', N'POSF0021', N'Recipients shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.VoucherNo', N'POSF0021', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.VoucherNoFilter', N'POSF0021', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.Quantity', N'POSF0021', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.MarkQuantity', N'POSF0021', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.QuantityReceive', N'POSF0021', N'Receive quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.ActualQuantity', N'POSF0021', N'Receive quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.InventoryName', N'POSF0021', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.SenderNameFilter', N'POSF0021', N'Diliverer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.EmployeeName', N'POSF0021', N'Bill creater name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.ReceiverNameFilter', N'POSF0021', N'Receiver name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.Status', N'POSF0021', N'Status', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.FromPeriodFilter', N'POSF0021', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.FromDateFilter', N'POSF0021', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0021.IsRefund', N'POSF0021', N'To', N'en-US', NULL

