-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2080- HRM
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
SET @FormID = 'HRMF2080';

SET @LanguageValue  = N'List of training requests';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training request code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.TrainingRequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of participants';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.NumberEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.TrainingFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.TrainingToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.IsConfirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2080.Attach',  @FormID, @LanguageValue, @Language;
