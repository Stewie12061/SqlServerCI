-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2071- HRM
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
SET @FormID = 'HRMF2071';

SET @LanguageValue = N'Update regular training plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Periodic phone plan code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is whole';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.IsAll' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingFieldName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.StartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DurationPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Validity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTimeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingFieldID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingFieldName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTime.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period of validity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTimeName.CB' , @FormID, @LanguageValue, @Language;

