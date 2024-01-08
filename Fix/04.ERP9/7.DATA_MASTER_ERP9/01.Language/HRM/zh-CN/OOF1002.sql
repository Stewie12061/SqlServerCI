-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1002- HRM
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF1002';

SET @LanguageValue = N'查看請假類型信息';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述（英文）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請假單類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.AbsentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工日類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.IsDTVS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'法規代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.RestrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工日類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'法規名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.RestrictName', @FormID, @LanguageValue, @Language;

