-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2130- HRM
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
SET @FormID = 'HRMF2130';

SET @LanguageValue  = N'Cost Recording';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training cost/schedule recording ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.RowDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.AssignedToUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CostAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost recording ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingCostID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual training duration';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training type ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training type name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;
