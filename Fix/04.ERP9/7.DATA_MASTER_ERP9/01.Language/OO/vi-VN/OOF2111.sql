-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2111- OO
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
SET @FormID = 'OOF2111';

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc cha';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/Nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/Nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc cha';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cố tình vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đánh giá {0}';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssessUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc mới';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskIDNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc mới';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskIDNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ chối hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đánh giá ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssessTargetGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu công việc(ID)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskSampleID', @FormID, @LanguageValue, @Language;