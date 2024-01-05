                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0010 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:05:34 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0010' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0010' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0010.POSF0002Title', N'POSF0010', N'{0} shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.SearchCustomerTitle', N'POSF0010', N'Select a customer', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.Title', N'POSF0010', N'Shop category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.AddressFilter', N'POSF0010', N'Address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.DivisionIDFilter', N'POSF0010', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.EmailFilter', N'POSF0010', N'Email', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.FaxFilter', N'POSF0010', N'Fax', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.DisabledFilter', N'POSF0010', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.ShopIDFilter', N'POSF0010', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.ObjectIDFilter', N'POSF0010', N'Customer ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.TelFilter', N'POSF0010', N'Tel', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.ShopNameFilter', N'POSF0010', N'Shop name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.Config', N'POSF0010', N'Config', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.ConfigPrice', N'POSF0010', N'Config pricelist', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0010.Disabled', N'POSF0010', N'Disabled', N'en-US', NULL

