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
SET @Language = 'vi-VN' 
SET @ModuleID = 'S';
SET @FormID = 'SF0080';

SET @LanguageValue = N'Thiết lập dữ liệu mặc định màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.Analysis', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản mục';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ValueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cột dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ColumnName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khoản mục';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.AnalysisValueID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khoản mục';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.AnalysisValue.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cột dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ColumnID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cột dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ColumnName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ModuleID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.ScreenName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SF0080.UserName.CB', @FormID, @LanguageValue, @Language;

