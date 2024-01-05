                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0006 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:04:08 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0006' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0006' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0006.DivisionID', N'POSF0006', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0006.ObjectTypeID01', N'POSF0006', N'Object type 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0006.ObjectTypeID02', N'POSF0006', N'Object type 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0006.IsDefault', N'POSF0006', N'Default', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0006.PaymentID01', N'POSF0006', N'Payment methods 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0006.PaymentID02', N'POSF0006', N'Payment methods 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0006.Title', N'POSF0006', N'Payment methods setup', N'en-US', NULL

