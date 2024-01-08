-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1011- HRM
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
SET @FormID = 'HRMF1011';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview form code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.InterviewTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the interview room format';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.InterviewTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Detailed form code'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DetailTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Result Format Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.ResultFormatName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To Value'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.ToValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From Value'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.FromValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Update Interview Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Title',  @FormID, @LanguageValue, @Language;
