                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ ReportView - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:40:38 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'ReportView' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'ReportView' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'ReportView.WareHouseID.CB', N'ReportView', N'Warehouse ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'ReportView.EmployeeID.CB', N'ReportView', N'Employee ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'ReportView.PaymentID.CB', N'ReportView', N'Mã PTTT', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'ReportView.WareHouseName.CB', N'ReportView', N'Warehouse name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'ReportView.EmployeeName.CB', N'ReportView', N'Receiver name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'ReportView.PaymentName.CB', N'ReportView', N'Payment name', N'en-US', NULL

