-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1010- HRM
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
SET @FormID = 'HRMF1010';

SET @LanguageValue  = N'Interview Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview form code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.InterviewTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the interview format';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.InterviewTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyName.CB',  @FormID, @LanguageValue, @Language;