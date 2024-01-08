-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1050- HRM
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
SET @FormID = 'HRMF1050';

SET @LanguageValue = N'Training Course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingType.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldName.CB' , @FormID, @LanguageValue, @Language;