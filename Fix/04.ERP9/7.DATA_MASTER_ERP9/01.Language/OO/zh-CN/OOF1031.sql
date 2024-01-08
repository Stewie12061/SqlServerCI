﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1031- OO
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
SET @FormID = 'OOF1031';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'步驟代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'步驟名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.APKMaster', @FormID, @LanguageValue, @Language;

