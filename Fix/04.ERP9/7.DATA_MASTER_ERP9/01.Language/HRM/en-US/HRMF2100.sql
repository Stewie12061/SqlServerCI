-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2100- HRM
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
SET @FormID = 'HRMF2100';

SET @LanguageValue = N'List of training schedules';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone schedule code/ Phone lock';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ScheduleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposed budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ProposeAmount_MT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training duration (expected0 from date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training of the whole company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.SpecificHours', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training type name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;
