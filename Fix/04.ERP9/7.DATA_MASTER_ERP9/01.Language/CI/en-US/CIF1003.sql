-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1003- CI
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
SET @FormID = 'CIF1003';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tk Salary Expenses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tk payable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.PayableAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personal income tax account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.PITAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tk management salary costs';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.ManagerExpAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attached to organization chart';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.IsOrganizationDiagram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1003.DivisionID', @FormID, @LanguageValue, @Language;

