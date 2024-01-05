-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1052- HRM
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
SET @FormID = 'HRMF1052';

SET @LanguageValue = N'Training Course View';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training Course Infomation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TabThongTinKhoaDaoTao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.StatusID' , @FormID, @LanguageValue, @Language;