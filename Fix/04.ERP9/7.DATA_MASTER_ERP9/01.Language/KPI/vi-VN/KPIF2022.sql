-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2022- KPI
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
SET @FormID = 'KPIF2022';

SET @LanguageValue = N'Chi tiết bảng  quy chuẩn (Up-Down) đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cứng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương mềm dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TargetSalesRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH Đỏ (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.RedLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH cảnh báo (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.WarningLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mốc thưởng KPI doanh số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TargetSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức thưởng KPI doanh số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.BonusSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức thưởng KPI quản lý';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.PercentKPIManager', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng hệ số lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng quy định giờ công vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TableViolatedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết bảng  quy chuẩn đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.ChiTietBangQuyChuanDanhGiaKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.DinhKem', @FormID, @LanguageValue, @Language;
