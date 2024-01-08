------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF1014 - S
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
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US ' 
SET @ModuleID = 'S';
SET @FormID = 'SF1014';
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Password setting';
EXEC ERP9AddLanguage @ModuleID, 'SF1014.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Change password';
EXEC ERP9AddLanguage @ModuleID, 'SF1016.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'SF1014.UserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'SF1014.UserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Old password';
EXEC ERP9AddLanguage @ModuleID, 'SF1014.OldPassword' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'SF1014.Password' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New password';
EXEC ERP9AddLanguage @ModuleID, 'SF1014.NewPassword' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;