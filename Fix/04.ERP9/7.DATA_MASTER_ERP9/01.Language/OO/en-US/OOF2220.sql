-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2220- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2220';

SET @LanguageValue = N'Mail inbox list';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.EmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mail ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of protocol';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.TypeOfEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email receipt time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sent mail time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.SendMailDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.CurEmailContent', @FormID, @LanguageValue, @Language;

