-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1002- CI
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
SET @FormID = 'CIF1002';

SET @LanguageValue = N'Detail department';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Division name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payroll Cost Account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payable account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.PayableAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PIT account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.PITAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manager payroll cost account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.ManagerExpAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attached to organization chart';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.IsOrganizationDiagram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.DepartmentNameE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payroll Cost Account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account payable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.PayableAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PIT account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.PITAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information department';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.CIF1002Group01Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'System information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1002.CIF1002Group02Title' , @FormID, @LanguageValue, @Language;

