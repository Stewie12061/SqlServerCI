                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0070 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:36:09 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0070' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0070' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportSaleTitle', N'POSF0070', N'Sell', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportSaleTitle', N'POSF0070', N'Sell', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportTitle', N'POSF0070', N'Report', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.POSF0071Title', N'POSF0070', N'Report', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.POSF0072Title', N'POSF0070', N'Report', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.POSF0073Title', N'POSF0070', N'Report', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.POSF0074Title', N'POSF0070', N'Report', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.POSF0070Title', N'POSF0070', N'Report chart', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.POSF0070Title', N'POSF0070', N'Report chart', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ToPeriod', N'POSF0070', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ToDate', N'POSF0070', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.DivisionID', N'POSF0070', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportID', N'POSF0070', N'Report code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ShopID', N'POSF0070', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.InventoryID', N'POSF0070', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MemberID', N'POSF0070', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportID', N'POSF0070', N'Report ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.Description', N'POSF0070', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.Description', N'POSF0070', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportImportExportSurvivalTitle', N'POSF0070', N'Import existing', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportImportExportSurvivalTitle', N'POSF0070', N'Import existing', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0071Title', N'POSF0070', N'POSF0070.MTF0071Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0071Title', N'POSF0070', N'POSF0070.MTF0071Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0072Title', N'POSF0070', N'POSF0070.MTF0072Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0072Title', N'POSF0070', N'POSF0070.MTF0072Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0073Title', N'POSF0070', N'POSF0070.MTF0073Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0073Title', N'POSF0070', N'POSF0070.MTF0073Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0074Title', N'POSF0070', N'POSF0070.MTF0074Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.MTF0074Title', N'POSF0070', N'POSF0070.MTF0074Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportName', N'POSF0070', N'Report name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.ReportName', N'POSF0070', N'Report name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.Title', N'POSF0070', N'Title', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.FromPeriod', N'POSF0070', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0070.FromDate', N'POSF0070', N'From date', N'en-US', NULL

