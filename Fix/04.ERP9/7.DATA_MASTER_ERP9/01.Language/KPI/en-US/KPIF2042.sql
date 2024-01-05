-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIT2042- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIT2042';

SET @LanguageValue = N'Effective salary calculation view';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.FixedSalary1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reality';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Reality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QTCM';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.QTCM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KHHL';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.KHHL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VHPT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.VHPT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RealValue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.RealValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Insurrance Percent';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.InsurrancePercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Premium Rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.PremiumRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Insurrance Money';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.InsurranceMoney', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sum Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.SumSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Income';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TotalIncome', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual effective salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.ActualEffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deductions';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Deductions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DepartmentID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DivisionID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effective salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Fixed Salary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Insurrance';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.Insurrance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TargetSales';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personal income';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.TNCN', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected income table';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.BangThuNhapDuKien', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value of participating work';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.GiaTriCongViecThamGia', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deductions';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.CacKhoanGiamTru', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.LastModifyDate', @FormID, @LanguageValue, @Language;