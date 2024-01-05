-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2102- HRM
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
SET @FormID = 'HRMF2102';


SET @LanguageValue = N'Training schedule view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule/course ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingCourseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ScheduleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposed budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ProposeAmount_MT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training duration (expected0 from date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training of the whole company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.FromDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ToDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ScheduleAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Proposed budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ProposeAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training proposal ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'List of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabEmployee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabCRMT00003',  @FormID, @LanguageValue, @Language;
