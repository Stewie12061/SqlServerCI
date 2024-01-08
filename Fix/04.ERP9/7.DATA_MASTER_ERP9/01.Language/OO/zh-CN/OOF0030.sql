-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0030- OO
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
SET @FormID = 'OOF0030';

SET @LanguageValue = N'設定工作時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'码数';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.YearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'適用日期自';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建者代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'遲到罰款';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.PunishLate', @FormID, @LanguageValue, @Language;

