-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0080- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF0080';

SET @LanguageValue = N'Analysis ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.Analysis', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value name';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ValueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Column name';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ColumnName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.AnalysisValueID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value name';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.AnalysisValue.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Column ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ColumnID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Column ame';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ColumnName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module name';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen name';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ScreenName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis name';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.UserName.CB', @FormID, @LanguageValue, @Language;