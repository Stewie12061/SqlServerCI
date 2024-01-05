-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0041- OO
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
SET @FormID = 'OOF0041';

SET @LanguageValue = N'Setting receive notifications';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EventID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EventName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SMS Template';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SMSTemplate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Send Notification';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SendNotification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Send Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Send SMS';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SendSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remind after day';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.RemindAfterDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EmailTemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EmailTemplateID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EmailTemplateName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.Warning', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeName.CB', @FormID, @LanguageValue, @Language;
