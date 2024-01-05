-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0003 - OO
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
SET @FormID = 'OOF0003';

SET @LanguageValue = N'Dashboard Công việc (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số văn bản đến';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.CountIncomingText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số văn bản đi';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.CountGoText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TotalRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số yêu cầu bị trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TotalRequestLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TotalTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số công việc bị trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TotalTaskLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TotalIssue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số vấn đề bị trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TotalIssueLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thể hiện số lượng văn bản theo trạng thái (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartStatusTextName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê tỷ lệ trạng thái {0} theo đơn vị (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartUCLName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê tỷ lệ trạng thái {0} theo nhân viên (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartUCLNameStaff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.BusinessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sắp xếp';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.OrderTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.LateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.CompleteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chưa xử lý';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.UnExcuteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.IssueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ trạng thái và tiến độ Công việc (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartStatusProcessTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ trạng thái và tiến độ Vấn đề (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartStatusProcessIssueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ trạng thái và tiến độ Yêu cầu (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartStatusProcessRequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Department', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng {0} theo phòng ban (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartStatisDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ {0}';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartPointHotColdName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Employee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm nóng (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.HotPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm lạnh (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ColdPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số công việc đã giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.CountTaskAssigned', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Hoàn thành công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.CompleteTaskPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Process', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số công việc đang theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.CountTaskFollowing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Hoàn thành vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.CompleteIssuePercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Performance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số văn bản đến';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.IncomingText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số văn bản đi';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.GoText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê tình trạng phê duyệt văn bản (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartStatusApproveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.SubtitleChartApprove', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc hôm nay';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TaskToday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc đang trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TaskLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.TaskType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách công việc theo trạng thái (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.ChartStatusTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thấp';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Low', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bình thường';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Normal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.High', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rất cao';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Highest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khẩn cấp';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Urgency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng quan công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.GeneralTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết team/cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.DetailTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.Newsfeed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0003.DivisionName.CB', @FormID, @LanguageValue, @Language;
------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Công việc------------------------------------------------
-- SET @LanguageValue = N'Tổng quan công việc';
-- EXEC ERP9AddLanguage @ModuleID, 'OOD0020.Title', 'OOD0020', @LanguageValue, @Language;

-- SET @LanguageValue = N'Chi tiết công việc';
-- EXEC ERP9AddLanguage @ModuleID, 'OOD0021.Title', 'OOD0021', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê tổng hợp (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0022.Title', 'OOD0022', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thể hiện số lượng văn bản theo trạng thái (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0023.Title', 'OOD0023', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê tỷ lệ trạng thái Công việc/Vấn đề/Yêu cầu theo đơn vị (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0024.Title', 'OOD0024', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ trạng thái và tiến độ Yêu cầu/Công việc/Vấn đề (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0025.Title', 'OOD0025', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng Công việc/vấn đề/Yêu cầu theo phòng ban (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0026.Title', 'OOD0026', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ điểm Nóng/Lạnh (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0027.Title', 'OOD0027', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê chi tiết (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0028.Title', 'OOD0028', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê tình trạng phê duyệt văn bản (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0029.Title', 'OOD0029', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê tỷ lệ trạng thái Công việc/Vấn đề/Yêu cầu theo nhân viên (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0030.Title', 'OOD0030', @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách công việc theo trạng thái (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0031.Title', 'OOD0031', @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách thông báo (WO)';
EXEC ERP9AddLanguage @ModuleID, 'OOD0032.Title', 'OOD0032', @LanguageValue, @Language;