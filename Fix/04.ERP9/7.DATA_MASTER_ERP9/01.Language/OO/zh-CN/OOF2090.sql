-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2090- OO
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
SET @FormID = 'OOF2090';

SET @LanguageValue = N'通知';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生效日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通知類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'過期日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.IsExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.ChooseFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.ChooseImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.FromToDate', @FormID, @LanguageValue, @Language;

