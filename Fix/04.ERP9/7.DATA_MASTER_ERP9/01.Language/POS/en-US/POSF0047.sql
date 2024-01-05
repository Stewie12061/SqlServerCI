                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0047 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:30:16 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0047' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0047' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportBH', N'POSF0047', N'Sell', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportBH', N'POSF0047', N'Sell', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.POSF0047Title', N'POSF0047', N'Report chart', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.POSF0047Title', N'POSF0047', N'Report chart', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportCL', N'POSF0047', N'Difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportCL', N'POSF0047', N'Difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportID', N'POSF0047', N'Report code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportID', N'POSF0047', N'Report code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.Description', N'POSF0047', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.Description', N'POSF0047', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportNK', N'POSF0047', N'Diary', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportNK', N'POSF0047', N'Diary', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportName', N'POSF0047', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportName', N'POSF0047', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0047.ReportXNT', N'POSF0047', N'Export-Import-Storage', N'en-US', NULL

