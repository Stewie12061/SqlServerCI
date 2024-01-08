-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2005- KPI
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
SET @FormID = 'KPIF2005';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.UnitKpiID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.UnitKpiName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsGroupPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.FrequencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Categorize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Benchmark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lũy kế thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.PerformTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lũy kế điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.PerformPointTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ thực hiện (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.PerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh/ Vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ConfirmUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ConfirmDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ thực hiện (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TotalPerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết kết quả tình hình thực hiện KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabInformationMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabInformationDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.StatusID',  @FormID, @LanguageValue, @Language;