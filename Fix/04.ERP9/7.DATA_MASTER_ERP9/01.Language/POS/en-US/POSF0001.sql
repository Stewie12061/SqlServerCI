                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0001 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:01:10 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0001' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0001' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0001.ShopID', N'POSF0001', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0001.ShopTypeID', N'POSF0001', N'Analysis code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0001.GroupInventoryID', N'POSF0001', N'Group inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0001.Title', N'POSF0001', N'Group code analysis shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0001.ShopTypeName', N'POSF0001', N'Analysis name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0001.Title2', N'POSF0001', N'Set up the analysis code group', N'en-US', NULL

