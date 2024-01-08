------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000 - CRM
--            Ngày tạo                                    Người tạo
--            07/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CMNF9001'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9001';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.Disabled', @FormID, N'Disabled', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.InventoryID', @FormID, N'Inventory', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.InventoryName', @FormID, N'Inventory name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.Title', @FormID, N'Choose inventory', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.UnitID', @FormID, N'Unit ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9001.UnitName', @FormID, N'Unit name', @LanguageID, NULL
