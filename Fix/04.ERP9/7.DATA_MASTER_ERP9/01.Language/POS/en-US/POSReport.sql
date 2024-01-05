                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSReport - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:39:47 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSReport' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSReport' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0069Title', N'POSReport', N'Consolidate sales by membership', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0048Title', N'POSReport', N'Report sales details', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0045Title', N'POSReport', N'Detailed sales report by store', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0046Title', N'POSReport', N'Sales details by store', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0076Title', N'POSReport', N'Sales details by membership', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ShopID', N'POSReport', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ShopID', N'POSReport', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ToPeriod', N'POSReport', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ToPeriod', N'POSReport', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ToDate', N'POSReport', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ToDate', N'POSReport', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.DivisionID', N'POSReport', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.DivisionID', N'POSReport', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.MemberID', N'POSReport', N'Member', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.EmployeeID.CB', N'POSReport', N'Employee ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.EmployeeID', N'POSReport', N'Employee', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.PaymentID', N'POSReport', N'Payment methods', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0045Title', N'POSReport', N'Note difference by each store', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0048Title', N'POSReport', N'Detailed sales records', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0064Title', N'POSReport', N'Detailed materials records', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.POSF0049Title', N'POSReport', N'Inventory diary note', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.EmployeeName.CB', N'POSReport', N'Receiver name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.FromPeriod', N'POSReport', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.FromPeriod', N'POSReport', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.FromDate', N'POSReport', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.FromDate', N'POSReport', N'From date', N'en-US', NULL

EXEC ERP9AddLanguage N'POS', N'POSReport.FromWareHouseID', N'POSReport', N'From warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ToWareHouseID', N'POSReport', N'To warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.FromInventoryID', N'POSReport', N'From inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSReport.ToInventoryID', N'POSReport', N'To inventory', N'en-US', NULL
