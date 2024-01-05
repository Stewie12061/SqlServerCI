-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2042- KPI
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
SET @FormID = 'KPIF2042';

SET @LanguageValue = N'Chi tiết tính lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIT2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cứng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương mềm dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương mềm thực tế';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.ActualEffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cứng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Fixed_Salary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng thu nhập dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.BangThuNhapDuKien', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị công việc tham gia';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.GiaTriCongViecThamGia', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thu nhập';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.ThuNhap', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các khoản giảm trừ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.CacKhoanGiamTru', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cứng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.FixedSalary1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả công việc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Reality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QTCM';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.QTCM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KHHL';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.KHHL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VHPT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.VHPT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đạt';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.RealValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.InsurrancePercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức đóng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.PremiumRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.InsurranceMoney', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thu nhập';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.SumSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực lĩnh';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TotalIncome', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các khoản trừ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Deductions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thu nhập cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TNCN', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hiểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Insurrance', @FormID, @LanguageValue, @Language;