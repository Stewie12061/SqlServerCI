-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1101- OO
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
SET @FormID = 'OOF1101';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group code';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.UserMarkedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1101.LastModifyUserID', @FormID, @LanguageValue, @Language;

