-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2060- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2060';

SET @LanguageValue = N'In/Out';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.IOName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Non-OT application has been created';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.IsApproved', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From now';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.BeginTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'It is time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Committee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Judging the type of abnormality';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.JugdeUnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unusual type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reality';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Fact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormal handling';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Method', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.HandleMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Execute', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Committee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.FromDate', @FormID, @LanguageValue, @Language;

