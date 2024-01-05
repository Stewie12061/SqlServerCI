-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1047- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1047';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1047.Title', @FormID, @LanguageValue, @Language;

