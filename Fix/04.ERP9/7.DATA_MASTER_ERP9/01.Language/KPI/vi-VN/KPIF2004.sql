-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2004- KPI
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
SET @FormID = 'KPIF2004';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.UnitKpiID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.UnitKpiName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsGroupPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.FrequencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Categorize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Benchmark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lũy kế thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.PerformTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lũy kế điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.PerformPointTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ thực hiện (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.PerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ConfirmUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ConfirmDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng điểm lũy kế';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ thực hiện (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TotalPerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật kết quả tình hình thực hiện KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Perform', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.PerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng điểm lũy kế';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.LangPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' Tỷ lệ thực hiện (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.LangPerformPercent', @FormID, @LanguageValue, @Language;

