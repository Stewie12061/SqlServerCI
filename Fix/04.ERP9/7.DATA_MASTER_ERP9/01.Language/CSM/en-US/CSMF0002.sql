-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF0002- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF0002';

SET @LanguageValue = N'Setting API Account for User by Firm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Firm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.Account', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Technical ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.TechnicalID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Firm ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.FirmID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Firm Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.FirmName.CB', @FormID, @LanguageValue, @Language;

