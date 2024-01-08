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
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2232';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發件人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'抄送';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.EmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'方法類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.TypeOfEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郵件發送時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郵件發送時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.SendMailDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.CurEmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2232.GroupReceiverID', @FormID, @LanguageValue, @Language;

