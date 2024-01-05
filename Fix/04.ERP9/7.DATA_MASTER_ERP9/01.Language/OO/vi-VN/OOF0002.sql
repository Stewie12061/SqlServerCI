-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0002 - OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF0002';

SET @LanguageValue = N'Dashboard Dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự án trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.LateProject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Performance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất so với cùng kỳ năm trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.PastPerformance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự án hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.CompleteProject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Process', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% hoàn thành dự án so với cùng kỳ năm trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.PastCompletePercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.TotalProject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ trạng thái Dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ChartProjectStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình thực hiện Dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ProjectImplement', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giờ còn lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.HoursRemain', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giờ hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.HoursComplete', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số giờ hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.TotalCompletePlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số giờ kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.TotalPlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Progress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Performance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số vấn đề tồn đọng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.TotalUnexcuteIssue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số Yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.TotalRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số công việc chưa hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.TotalUnexcuteTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.TotalMilestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng Công việc theo trạng thái (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ChartTaskStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng Vấn đề theo trạng thái (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ChartIssuesStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng Milestone theo trạng thái (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ChartMilestoneStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng Yêu cầu theo trạng thái (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ChartRequestStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Milestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Request', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Task', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Issue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.OutDateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đang làm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.DoingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chưa xử lý';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.UnexcuteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.CompleteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình công việc, độ trễ theo thành viên Dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ChartTIMRProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Employee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm nóng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.HotPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm lạnh';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ColdPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sắp xếp theo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Mode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.BusinessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ tiến độ dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.ProjectChartName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.Time', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng quan dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.GeneralProject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết team/cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.DetailProject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0002.DivisionName.CB', @FormID, @LanguageValue, @Language;
------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Dự án------------------------------------------------
-- SET @LanguageValue = N'Tổng quan dự án';
-- EXEC ERP9AddLanguage @ModuleID, 'OOD0012.Title', 'OOD0012', @LanguageValue, @Language;

-- SET @LanguageValue = N'Chi tiết dự án';
-- EXEC ERP9AddLanguage @ModuleID, 'OOD0013.Title', 'OOD0013', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê tổng hợp (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0014.Title', 'OOD0014', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ trạng thái dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0015.Title', 'OOD0015', @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình thực hiện dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0016.Title', 'OOD0016', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê chi tiết (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0017.Title', 'OOD0017', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng Công việc/Yêu cầu/Vấn đề/Milestone theo trạng thái (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0018.Title', 'OOD0018', @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình công việc, độ trễ theo thành viên dự án (PR)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0019.Title', 'OOD0019', @LanguageValue, @Language;