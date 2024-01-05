-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2093- OO
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
SET @FormID = 'OOF2093';

SET @LanguageValue = N'Inform Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effective Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inform type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiration Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.DinhKem', @FormID, @LanguageValue, @Language;

