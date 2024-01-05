                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0059 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:33:49 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0059' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0059' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0059.Disabled', N'POSF0059', N'Không hiển thị', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.TableID', N'POSF0059', N'Table ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.ShopID', N'POSF0059', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.DivisionID', N'POSF0059', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.AreaID', N'POSF0059', N'Mã khu vực', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.Description', N'POSF0059', N'Mô tả', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.TableName', N'POSF0059', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.TableNameE', N'POSF0059', N'Table name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.POSF0059Group01Title', N'POSF0059', N'Table info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.POSF0059Group02Title', N'POSF0059', N'System info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0059.Title', N'POSF0059', N'Table info details', N'en-US', NULL

