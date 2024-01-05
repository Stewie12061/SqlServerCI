                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0027 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:19:43 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0027' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0027' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0027.POSF00271Title', N'POSF0027', N'{0} export bills', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.EvoucherNo', N'POSF0027', N'Voucher reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.Title', N'POSF0027', N'Export inventory category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.ToPeriodFilter', N'POSF0027', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.ToDateFilter', N'POSF0027', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.DescriptionFilter', N'POSF0027', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.DivisionID', N'POSF0027', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.ShopID', N'POSF0027', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.WareHouseID', N'POSF0027', N'Export warehouse ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.EmployeeID', N'POSF0027', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.VoucherDate', N'POSF0027', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.RecipientName', N'POSF0027', N'Receiver user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.VoucherNo', N'POSF0027', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.RefVoucherNo', N'POSF0027', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.EmployeeName', N'POSF0027', N'Bill creater name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.Status', N'POSF0027', N'Status', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.FromPeriodFilter', N'POSF0027', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0027.FromDateFilter', N'POSF0027', N'From date', N'en-US', NULL

