-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0050- OO
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
SET @FormID = 'OOF0050';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對像類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不使用評估';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.NotUseAssess', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目標組';
EXEC ERP9AddLanguage @ModuleID, 'OOF0050.TargetsGroupID', @FormID, @LanguageValue, @Language;

