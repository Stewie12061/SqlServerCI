-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2183- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2183';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.ContractTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.ContractTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some contracts';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working from day one';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2183.WorkEndDate', @FormID, @LanguageValue, @Language;

