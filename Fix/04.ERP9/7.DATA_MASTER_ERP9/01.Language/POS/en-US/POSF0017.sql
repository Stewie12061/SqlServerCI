                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0017 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:13:20 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0017' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0017' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0017.POSF00171Title', N'POSF0017', N'{0} inventory slip', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.Title', N'POSF0017', N'Inventory slip category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.ToPeriodFilter', N'POSF0017', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.ToDateFilter', N'POSF0017', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.DescriptionFilter', N'POSF0017', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.DivisionIDFilter', N'POSF0017', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.DivisionIDListFilter', N'POSF0017', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.ShopIDFilter', N'POSF0017', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.VoucherDateFilter', N'POSF0017', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.EmployeeNameFilter', N'POSF0017', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.IntentoryOrBardcodeFilter', N'POSF0017', N'Enter inventory code / Scan bar code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.VoucherNoFilter', N'POSF0017', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.FromPeriodFilter', N'POSF0017', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0017.FromDateFilter', N'POSF0017', N'From date', N'en-US', NULL

