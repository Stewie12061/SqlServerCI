-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1049- KPI
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
SET @FormID = 'KPIF1049';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin công thức tính chỉ tiêu KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabFormulaCalculatorInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabCRMT00003', @FormID, @LanguageValue, @Language;