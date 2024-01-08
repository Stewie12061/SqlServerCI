-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2092- OO
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
SET @FormID = 'OOF2092';

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生效日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通知類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'明細';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'過期日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.IsExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.ChooseFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.ChooseImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.FromToDate', @FormID, @LanguageValue, @Language;

