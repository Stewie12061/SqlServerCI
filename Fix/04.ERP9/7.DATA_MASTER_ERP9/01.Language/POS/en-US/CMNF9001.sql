                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF9001 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 10:43:00 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CMNF9001' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'CMNF9001.DivisionID', N'CMNF9001', N'Branch', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'CMNF9001.Title', N'CMNF9001', N'Select an item', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'CMNF9001.IsCommon', N'CMNF9001', N'Commom', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'CMNF9001.Disabled', N'CMNF9001', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'CMNF9001.UnitID', N'CMNF9001', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'CMNF9001.InventoryID', N'CMNF9001', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'CMNF9001.UnitName', N'CMNF9001', N'Unit name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'CMNF9001.InventoryName', N'CMNF9001', N'Inventory name', N'en-US', NULL

