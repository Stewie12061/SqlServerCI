-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1048- KPI
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
SET @FormID = 'KPIF1048';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật công thức tính chỉ tiêu KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhấn F4 để chọn tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.Placeholder', @FormID, @LanguageValue, @Language;
