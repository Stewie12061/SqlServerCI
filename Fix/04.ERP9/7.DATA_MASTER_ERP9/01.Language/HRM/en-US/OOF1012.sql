-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1012- HRM
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
SET @FormID = 'OOF1012';

SET @LanguageValue = N'Unusual type View';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unusual Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Vie)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle Method';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.HandleMethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle Method Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.HandleMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unusual type Infomation';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.SubTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.AbsentTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.AbsentTypeName' , @FormID, @LanguageValue, @Language;
