-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0402- HRM
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
SET @FormID = 'HF0402';

SET @LanguageValue = N'List of declare initial leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team name';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Initial leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0402.FirstLoaDays', @FormID, @LanguageValue, @Language;

