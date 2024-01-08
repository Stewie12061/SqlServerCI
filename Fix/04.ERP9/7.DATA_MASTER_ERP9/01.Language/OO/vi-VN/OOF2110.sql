-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2110- OO
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
SET @FormID = 'OOF2110';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc cha';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ mục công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/Nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc cha';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepName.CB', @FormID, @LanguageValue, @Language;

---------------------------------Modified by Tấn Thành ON 15/10/2020------------------------------
SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualTime', @FormID, @LanguageValue, @Language;

