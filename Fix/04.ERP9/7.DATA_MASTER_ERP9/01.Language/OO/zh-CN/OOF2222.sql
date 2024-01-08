-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2222- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2222';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發件人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'抄送';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.EmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'方法類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.TypeOfEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收電子郵件的時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郵件發送時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.SendMailDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.CurEmailContent', @FormID, @LanguageValue, @Language;

