-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2200 - OO
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
SET @FormID = 'OOF2200';

SET @LanguageValue = N'List Notification';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ListNotification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Read more';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ReadMore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Records/Page';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ItemsPerPage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List Notification';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Message Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.MessageType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.IsRead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'No Record';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.NoRecord', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ScreenName.CB', @FormID, @LanguageValue, @Language;