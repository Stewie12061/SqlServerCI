-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0403- HRM
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
SET @FormID = 'HF0403';

SET @LanguageValue = N'Initial leave Update';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team name';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Initial leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0403.FirstLoaDays', @FormID, @LanguageValue, @Language;

