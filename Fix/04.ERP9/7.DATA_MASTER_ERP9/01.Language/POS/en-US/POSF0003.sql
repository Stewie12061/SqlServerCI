                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0003 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:03:06 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0003' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0003' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0003.Currency', N'POSF0003', N'Currency', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.CurrentName', N'POSF0003', N'The value is converted based on', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.CurrencyID', N'POSF0003', N'Currency ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.ChangeMoney', N'POSF0003', N'Rules for redeem money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.ChangePoint', N'POSF0003', N'Rules for redeem points', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.Point', N'POSF0003', N'Point', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.Money', N'POSF0003', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.CurrencyName', N'POSF0003', N'Currency name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.Title', N'POSF0003', N'Set up point calculation', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.DownCard', N'POSF0003', N'Automatically downgrade the card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.UpdateCard', N'POSF0003', N'Automatically upgrade cards', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.ExampleMoney', N'POSF0003', N'Example: {0} {1} = {2} point', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0003.ExamplePoint', N'POSF0003', N'Example {0} point = {1} {2}', N'en-US', NULL

