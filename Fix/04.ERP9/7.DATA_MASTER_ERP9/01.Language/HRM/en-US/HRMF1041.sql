-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1041- HRM
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
SET @FormID = 'HRMF1041';

SET @LanguageValue  = N'Training field update'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Field Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Related To Type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1041.RelatedToTypeID', @FormID, @LanguageValue, @Language;

