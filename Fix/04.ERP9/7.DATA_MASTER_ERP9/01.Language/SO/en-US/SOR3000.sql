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
-- SELECT * FROM A00001 WHERE FormID = 'SOR3000'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOR3000';

EXEC ERP9AddLanguage @ModuleID, N'SOR3000.Title', @FormID, N'Details of quotation', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.EmployeeID', @FormID, N'Employee', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.FromAccountName', @FormID, N'From customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.FromInventoryName', @FormID, N'From inventory', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.FromSalesManName', @FormID, N'From salesman', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.GroupID', @FormID, N'Analysis group', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.InventoryID', @FormID, N'Inventory', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.ObjectID', @FormID, N'Customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.Title', @FormID, N'Detail quatation', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.ToAccountName', @FormID, N'To customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.ToInventoryName', @FormID, N'To inventory', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3000.ToSalesManName', @FormID, N'To salesman', @LanguageID, NULL
