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

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview Type ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.InterviewTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview Type Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.InterviewTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyName.CB',  @FormID, @LanguageValue, @Language;