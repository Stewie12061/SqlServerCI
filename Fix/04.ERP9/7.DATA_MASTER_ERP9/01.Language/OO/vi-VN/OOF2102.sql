-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2102- OO
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
SET @FormID = 'OOF2102';

SET @LanguageValue = N'Xem chi tiết dự án/nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghiệm thu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CheckingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trưởng dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LeaderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại liên quan';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trưởng dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LeaderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TargetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ObjectTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết dự án/nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ChiTietDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ThongTinMoTa', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CongViecDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đánh giá {0}';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssessUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ Gantt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GanttChart', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xuất file PDF';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GanttChartPDF', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TitleObject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuần';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Week', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhập chi phí dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.UpdateProjectCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TabCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TabCRMT10001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TabCRMT20801', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chiết khấu NC';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DiscountFactorNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chiết khấu KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DiscountFactorKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chiết khấu dịch vụ KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DiscountFactorKHCUService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TabCMNT90051', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đăng ký thông tin dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DangKy', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu/Target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ChiTieuCongViec', @FormID, @LanguageValue, @Language;