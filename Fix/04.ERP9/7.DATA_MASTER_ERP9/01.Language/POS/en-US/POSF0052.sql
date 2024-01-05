                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0052 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:31:15 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0052' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0052' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0052.PopupAddTitle', N'POSF0052', N'Update table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.Title', N'POSF0052', N'List of tables', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.DivisionID', N'POSF0052', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.Disabled', N'POSF0052', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.TableID', N'POSF0052', N'Table ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.ShopID', N'POSF0052', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.AreaID', N'POSF0052', N'Area ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.TableName', N'POSF0052', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.TableNameE', N'POSF0052', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0052.DisabledFilter', N'POSF0052', N'Disabled filter', N'en-US', NULL

