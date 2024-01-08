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

SET @FormID = 'QCF3009';
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Title', @FormID, N'Product quality tracking reports', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.ToDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.FromDate', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Department', @FormID, N'Department', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Object', @FormID, N'Customer', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Inventory', @FormID, N'Inventory', @Language;
