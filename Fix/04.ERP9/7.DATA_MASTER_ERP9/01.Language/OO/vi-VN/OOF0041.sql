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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF0041';

SET @LanguageValue = N'Thiết lập nhận thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EventID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EventName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SendNotification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SMS';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SendSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày nhắc lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.RemindAfterDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EmailTemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu SMS';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.SMSTemplate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EmailTemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EmailTemplateID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.EmailTemplateName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cảnh báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.Warning', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cảnh báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cảnh báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.WarningTypeName.CB', @FormID, @LanguageValue, @Language;
