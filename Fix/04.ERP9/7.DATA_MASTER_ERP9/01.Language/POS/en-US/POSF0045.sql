                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0045 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:29:46 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0045' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0045' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0045.POSF0045Title', N'POSF0045', N'Report on the difference of each store', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0045.ShopID', N'POSF0045', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0045.ToPeriod', N'POSF0045', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0045.ToDate', N'POSF0045', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0045.DivisionID', N'POSF0045', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0045.FromPeriod', N'POSF0045', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0045.FromDate', N'POSF0045', N'From date', N'en-US', NULL

