-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1042- HRM
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
SET @FormID = 'HRMF1042';

SET @LanguageValue  = N'Training field view'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.Title ',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Field Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field infomation'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.StatusID',  @FormID, @LanguageValue, @Language;
