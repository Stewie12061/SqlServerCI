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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF1011';

SET @LanguageValue = N'更新異常類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'異常類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋（越南文）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述（英文）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'方法';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.HandleMethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.HandleMethodName', @FormID, @LanguageValue, @Language;

