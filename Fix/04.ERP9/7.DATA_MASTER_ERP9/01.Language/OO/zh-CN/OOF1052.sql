-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1052- OO
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
SET @FormID = 'OOF1052';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'樣本代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'樣本名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.ProjectSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.IsCommon', @FormID, @LanguageValue, @Language;

