-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2003- KPI
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
SET @FormID = 'KPIF2003';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh/ Vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh/ Vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ConfirmUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ConfirmDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ thực hiện (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TotalPerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentID.Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức danh/ vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chức danh/ vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách kết quả tình hình thực hiện KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.Title', @FormID, @LanguageValue, @Language;

