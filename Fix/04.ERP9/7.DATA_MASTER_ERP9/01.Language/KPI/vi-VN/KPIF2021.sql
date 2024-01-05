-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2021- KPI
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
SET @FormID = 'KPIF2021';

SET @LanguageValue = N'Cập nhật bảng quy chuẩn (Up-Down) đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cứng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương mềm dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TargetSalesRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH Đỏ (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.RedLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH cảnh báo (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.WarningLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng hệ số lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.FromToPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên quản lý';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.ManagementStaff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mốc thưởng KPI doanh số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TargetSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức thưởng KPI doanh số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.BonusSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức thưởng KPI quản lý';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.PercentKPIManager', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng quy định giờ công vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableViolatedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableViolatedID.CB', @FormID, @LanguageValue, @Language;
