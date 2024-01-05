                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0023 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:17:41 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0023' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0023' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0023.POSF00231Title', N'POSF0023', N'{0} adjustment tab', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.Uneven', N'POSF0023', N'Difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.ChooseVoucher', N'POSF0023', N'Select inventory slip', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.Title', N'POSF0023', N'Corrections tab category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.ToPeriodFilter', N'POSF0023', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.ToDateFilter', N'POSF0023', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.Description', N'POSF0023', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.DescriptionFilter', N'POSF0023', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.DivisionIDFilter', N'POSF0023', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.UnitID', N'POSF0023', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.InventoryID', N'POSF0023', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.VoucherDateFilter', N'POSF0023', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.PreparedByFilter', N'POSF0023', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.VoucherNoFilter', N'POSF0023', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.ChangeQuantity', N'POSF0023', N'Adjusted quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.CheckQuantity', N'POSF0023', N'Check quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.StockQuantity', N'POSF0023', N'Stock quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.InventoryName', N'POSF0023', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.FromPeriodFilter', N'POSF0023', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.FromDateFilter', N'POSF0023', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0023.StatusInventory', N'POSF0023', N'Status', N'en-US', NULL
