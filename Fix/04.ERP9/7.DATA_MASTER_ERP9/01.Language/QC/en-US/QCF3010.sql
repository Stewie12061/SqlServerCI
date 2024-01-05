-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2050 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'QC';

SET @FormID = 'QCF3010';
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Title', @FormID, N'Product standard parameter test report', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.ToDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.FromDate', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Standard', @FormID, N'Standard', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Object', @FormID, N'Customer', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Inventory', @FormID, N'Inventory', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Phase', @FormID, N'Phase', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.AssessType', @FormID, N'Assessment type', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Assess', @FormID, N'Assessment', @Language;



