-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2072- HRM
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
SET @FormID = 'HRMF2072';

SET @LanguageValue = N'Regular training plan view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regular training plan ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TrainingPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is whole';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.IsAll' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TrainingFieldName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.StartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.DurationPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.RepeatTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Validity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.RepeatTimeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regular training plan information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabThongKeHoachDaoTaoDinhKy' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regular training plan details';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabChiTietKeHoachDaoTaoDinhKy' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.StatusID' , @FormID, @LanguageValue, @Language;