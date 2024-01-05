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
-- SELECT * FROM A00001 WHERE FormID = 'SOR3002'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOR3002';

EXEC ERP9AddLanguage @ModuleID, N'SOR3002.CurrencyID', @FormID, N'Currency type', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.CurrencyID.CB', @FormID, N'Currency ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.CurrencyName.CB', @FormID, N'Currency name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.FromAccountName', @FormID, N'From customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.FromInventoryName', @FormID, N'From inventory', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.FromSalesManName', @FormID, N'From salesman', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.GroupID', @FormID, N'Analysis group', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.Title', @FormID, N'Sales order details', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.ToAccountName', @FormID, N'To customer', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.ToInventoryName', @FormID, N'To inventory', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOR3002.ToSalesManName', @FormID, N'To salesman', @LanguageID, NULL