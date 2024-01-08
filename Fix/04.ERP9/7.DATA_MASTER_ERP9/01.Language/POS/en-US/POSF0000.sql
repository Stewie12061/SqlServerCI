                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 10:58:03 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0000' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0000' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0000.SystemConfig', N'POSF0000', N'System setting', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.System', N'POSF0000', N'System', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.ClosePeriod', N'POSF0000', N'Lock the accounting period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.OpenPeriod', N'POSF0000', N'Accounting period open', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.Shop1', N'POSF0000', N'Group code analysis shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.PageSize', N'POSF0000', N'Number of lines per page', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.PointNo', N'POSF0000', N'Set up point calculation', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.Common', N'POSF0000', N'General setup', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.Shop2', N'POSF0000', N'Set up the analysis code group', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.Payment', N'POSF0000', N'Setup peyment method', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.VoucherNo', N'POSF0000', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0000.BILL', N'POSF0000', N'Manage print templates', N'en-US', NULL

