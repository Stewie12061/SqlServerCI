-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2230- OO
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
SET @FormID = 'OOF2230';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發件人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'抄送';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.EmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改用戶';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郵件代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'方法類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.TypeOfEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郵件發送時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發送時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.SendMailDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.CurEmailContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郵件接收組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.GroupReceiverID', @FormID, @LanguageValue, @Language;

