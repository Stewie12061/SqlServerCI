-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2040- KPI
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
SET @FormID = 'KPIF2040';

SET @LanguageValue = N'Danh mục lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cứng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương mềm dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương mềm thực tế';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.ActualEffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.CalculateEffectivesalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Theo kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.CheckListPeriodControl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.DepartmentName', @FormID, @LanguageValue, @Language;
