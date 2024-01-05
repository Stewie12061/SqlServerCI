-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2232- OO
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
SET @FormID = 'OOF2232';

SET @LanguageValue = N'Email outbox view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.EmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mail ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of protocol';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.TypeOfEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sent email time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sent email time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.SendMailDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CurEmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mail content';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.NoiDungMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mail details';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.ThongTinChiTietMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Description', @FormID, @LanguageValue, @Language;
