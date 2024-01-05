                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00152 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:11:51 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00152' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00152' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00152.VoucherTo', N'POSF00152', N'To voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.DescriptionDetail', N'POSF00152', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.DescriptionMaster', N'POSF00152', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.UnitIDDetail', N'POSF00152', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.Title', N'POSF00152', N'Inheritance', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.VoucherType', N'POSF00152', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.ObjectIDMaster', N'POSF00152', N'Object ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.InventoryIDDetail', N'POSF00152', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.VoucherDateMaster', N'POSF00152', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.InvoiceDateMaster', N'POSF00152', N'Invoice date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.VoucherNoDetail', N'POSF00152', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.VoucherNoMaster', N'POSF00152', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.InvoiceNoMaster', N'POSF00152', N'Bill NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.QuantityDetail', N'POSF00152', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.ObjectNameMaster', N'POSF00152', N'Object name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.InventoryNameDetail', N'POSF00152', N'Order name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00152.VoucherFrom', N'POSF00152', N'From voucher date', N'en-US', NULL

