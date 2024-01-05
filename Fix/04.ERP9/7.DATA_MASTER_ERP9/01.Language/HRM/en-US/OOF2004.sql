
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2004- OO
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @FormID = 'OOF2004';

SET @LanguageValue = N'Employee information';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EmployeeID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time off work';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.ConvertLeaveDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Competency assessment history';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.btnHistory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employees violating';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.UserBlackList' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Error of violation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.DetailBlackList' , @FormID, @LanguageValue, @Language;