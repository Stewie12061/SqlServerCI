-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2112- OO
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
SET @FormID = 'OOF2112';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu (kế hoạch)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc (kế hoạch)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ (kế hoạch)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/Nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc cha';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.XemChiTietCongViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin checklist công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ThongTinChecklist', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ThongTinMoTa', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đánh giá công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DanhGiaCongViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thấp';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.low', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bình thường';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.normal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.high', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rất cao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.veryhigh', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cố tình vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DanhSachNguoiTheoDoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SaleOrderID', @FormID, @LanguageValue, @Language;
