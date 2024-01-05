                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0050 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:30:50 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0050' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0050' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0050.PriceTableID', N'POSF0050', N'Price list', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0050.Description', N'POSF0050', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0050.DivisionID', N'POSF0050', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0050.ShopID', N'POSF0050', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0050.AreaID', N'POSF0050', N'Area ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0050.TimeID', N'POSF0050', N'Time ', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0050.Title', N'POSF0050', N'Set up link area - price list', N'en-US', NULL

