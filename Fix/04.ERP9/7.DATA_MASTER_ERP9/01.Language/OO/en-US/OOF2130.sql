-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2130- OO
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
SET @FormID = 'OOF2130';

SET @LanguageValue = N'Task assessment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Date (Actual)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date (Actual)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date (Actual)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Date (Actual)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From To Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets Group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets Group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssessUserName', @FormID, @LanguageValue, @Language;

