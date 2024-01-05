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
SET @FormID = 'HRMF1011'

SET @LanguageValue  = N'Interview Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.InterviewTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
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

SET @LanguageValue  = N'Interview Type Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.InterviewTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Update Interview Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Title',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Department ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyName.CB',  @FormID, @LanguageValue, @Language;
