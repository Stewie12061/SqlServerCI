                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0068 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:35:21 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0068' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0068' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0068.Title', N'POSF0068', N'Select a customer', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0068.ObjectID', N'POSF0068', N'Customer ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0068.PlaceHolder', N'POSF0068', N'Enter the code / customer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0068.ObjectName', N'POSF0068', N'Customer name', N'en-US', NULL

