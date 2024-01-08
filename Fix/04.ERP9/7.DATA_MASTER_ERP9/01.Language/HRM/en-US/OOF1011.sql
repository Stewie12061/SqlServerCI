-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1011- HRM
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
SET @FormID = 'OOF1011';

SET @LanguageValue = N'Unusual types Update';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unusual Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Vie)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle Method';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.HandleMethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle Method';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Treatment methods';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.HandleMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.AbsentTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.AbsentTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.AbsentTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.AbsentTypeName.CB' , @FormID, @LanguageValue, @Language;
