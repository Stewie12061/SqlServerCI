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
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2090';




SET @LanguageValue = N'Notification List';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notification';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effective Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notification type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiry date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.IsExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.EmployeeID', @FormID, @LanguageValue, @Language;

