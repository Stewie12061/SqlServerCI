-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1012- HRM
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
SET @FormID = 'HRMF1012';

SET @LanguageValue = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview form code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.InterviewTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the interview room format';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.InterviewTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From {0} to {1}';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create User ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create Date'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify User ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify Date'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Interview Type Detail'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Detail Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DetailTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Result Format'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.ResultFormat',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To Value'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.ToValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From Value'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.FromValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Interview Type Detail'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.TabInfo1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Interview Type Info'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.TabInfo',  @FormID, @LanguageValue, @Language;
