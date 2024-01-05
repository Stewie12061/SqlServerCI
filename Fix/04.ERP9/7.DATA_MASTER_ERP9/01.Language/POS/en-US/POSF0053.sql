                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0053 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:31:38 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0053' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0053' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0053.PopupAddTitle', N'POSF0053', N'Update table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0053.Description', N'POSF0053', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0053.Disabled', N'POSF0053', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0053.TableID', N'POSF0053', N'Table ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0053.AreaID', N'POSF0053', N'Area ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0053.TableName', N'POSF0053', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0053.TableNameE', N'POSF0053', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0053.Title', N'POSF0053', N'Table info', N'en-US', NULL

