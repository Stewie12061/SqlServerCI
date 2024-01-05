-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0001 - OO
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
SET @FormID = 'OOF0001';

SET @LanguageValue = N'Dashboard';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dashboard';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Title', 'OOF0001', @LanguageValue, @Language;

SET @LanguageValue = N'Công việc hôm nay';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupTaskToday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc chưa xử lý';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupTaskNotHandle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupNotification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupChart', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Time', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.btnUpdateLabel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ tiến độ dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.ProjectChartName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực tế hoàn thành (giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch thực hiện (giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.PlanPercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đọc thêm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.ReadMore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành quả KPI của bạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupKPI', @FormID, @LanguageValue, @Language;
---
SET @LanguageValue = N'Hoàn thành công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.TaskKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số NET';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.SaleNetKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Violated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Tỷ lệ hoàn thành:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.PercentCompleteTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Tiền thưởng:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.BonusKPITask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Tổng doanh số:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.TotalSaleNet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Tiền thưởng:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.BonusSaleNet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Tỉ lệ hoàn thành:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.PercentCompleteTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Lương cứng tháng này:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.BaseSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Tỷ lệ vi phạm:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.ViolatedPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Khoản tiền bị trừ:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.ViolatedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các khoản giảm trừ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.TitleInsurrance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Mức đóng bảo hiểm:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.InsurranceMoney', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Phần trăm bảo hiểm:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.InsurrancePercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Thuế thu nhập cá nhân:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.PersonalIncome', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Tổng các khoản giảm trừ:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.TotalInsurrance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thu nhập';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.TitleIncurred', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Lương mềm tháng này:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.IncurredSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Thực lĩnh:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.RealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Lương mềm tháng trước:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.IncurredSalaryLastMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lọc dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.btnFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm hoàn thành (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.PercentProgressCompleted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ điểm nóng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupWarm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng hợp';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.General', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối 
lượng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Mass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chưa xử lý(%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.UnProcessed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Request', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Milestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Task', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Issue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trễ(%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Late', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'YC: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.YC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' - MS: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.MS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' - CV: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.T', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' - VD: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.VD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'YC';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.RQDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MS';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.MSDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CV';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.TDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VD';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.IDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công ty';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Company', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không có dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.NoRecord', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc đã giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupAssignedJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc đang theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupTrackingWord', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.GroupDocument', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chúc mừng sinh nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.BirthToDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sắp đến sinh nhật của';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.BirthDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Happy Pride Day!';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.HappyPrideDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.RequireSupport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoàn thành(%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Complete', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'HT';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.SRDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Newsfeed';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Newsfeed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workspace';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.Workspace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF0001.SignedStatusID', @FormID, @LanguageValue, @Language;
------------------------------------Ngôn ngữ màn hình phân quyền Dashboard OO------------------------------------------------