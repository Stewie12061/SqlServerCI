-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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


SET @Language = 'en-US';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1012'

SET @LanguageValue  = N'Interview Type ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.InterviewTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DutyID',  @FormID, @LanguageValue, @Language;

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

SET @LanguageValue  = N'Interview Type Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.InterviewTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Interview Type Info'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Note',  @FormID, @LanguageValue, @Language;

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