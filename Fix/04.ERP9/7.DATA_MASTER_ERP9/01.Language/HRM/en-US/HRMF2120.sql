-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2120- HRM
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
SET @FormID = 'HRMF2120';

SET @LanguageValue  = N'Result Recording List';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training type name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training type ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code to record DT results/schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingScheduleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Propose recommendations';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General assessment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ResultTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General assessment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ResultTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code to record results';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.APK', @FormID, @LanguageValue, @Language;

