------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2110 
-----------------------------------------------------------------------------------------------------
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'S';
SET @FormID = 'SF2110';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Email server config';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Title' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Server (SMTP/POP/IMAP)';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Server' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Port' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.DisplayName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Password' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Secure Sockets Layer';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EnableSsl' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;