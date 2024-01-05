-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2231- OO
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
SET @FormID = 'OOF2231';

SET @LanguageValue = N'Update outbox email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.EmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mail ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of protocol';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.TypeOfEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sent email time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sent email time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.SendMailDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2231.CurEmailContent', @FormID, @LanguageValue, @Language;

