-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2082- HRM
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
SET @FormID = 'HRMF2082';


SET @LanguageValue  = N'Training request view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training request ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TrainingRequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.NumberEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TrainingFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TrainingToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.IsConfirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training request information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2082.StatusID',  @FormID, @LanguageValue, @Language;