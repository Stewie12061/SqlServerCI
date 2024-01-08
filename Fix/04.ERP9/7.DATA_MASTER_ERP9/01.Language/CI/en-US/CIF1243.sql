                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1243 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:19:23 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1243' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1243' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1243.Title', N'CIF1243', N'Update details inventory sale off', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1243.ToQuantity', N'CIF1243', N'To quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1243.PromoteTypeID', N'CIF1243', N'Promotion type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1243.PromoteTypeName', N'CIF1243', N'Promotion type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1243.InventoryID', N'CIF1243', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1243.InventoryName', N'CIF1243', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1243.FromQuantity', N'CIF1243', N'From quantity', N'en-US', NULL

