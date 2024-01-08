-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2133- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2133';

SET @LanguageValue = N'工序清單之選擇';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'流程程式碼';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工段名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'順序';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.Notes', @FormID, @LanguageValue, @Language;

