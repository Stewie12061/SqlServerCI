-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1000- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1000';

SET @LanguageValue = N'Division name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payroll Cost Account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payable account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.PayableAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PIT account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.PITAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manager payroll cost account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.ManagerExpAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attached to organization chart';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.IsOrganizationDiagram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of departments';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1000.DivisionID', @FormID, @LanguageValue, @Language;

