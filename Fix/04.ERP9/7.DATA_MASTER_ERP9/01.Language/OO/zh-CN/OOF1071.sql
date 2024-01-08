-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1071- OO
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
SET @FormID = 'OOF1071';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類別代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.CategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名單名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附加文件';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附加文件';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件文件名';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF1071.LastModifyDate', @FormID, @LanguageValue, @Language;

