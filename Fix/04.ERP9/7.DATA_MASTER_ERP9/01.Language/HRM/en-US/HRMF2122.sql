-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2122- HRM
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
SET @FormID = 'HRMF2122';


SET @LanguageValue  = N'Result recording view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training result/schedule recording ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingScheduleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recommendations';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General assessment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.ResultTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General assessment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.ResultTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result recording ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TrainingResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.StatusTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.ResultName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Result recording information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'List of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.SubTitle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2122.StatusID',  @FormID, @LanguageValue, @Language;
