-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2101- OO
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
SET @FormID = 'OOF2101';

SET @LanguageValue = N'Cập nhật dự án/nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghiệm thu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CheckingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trưởng dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LeaderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại liên quan';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trưởng dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LeaderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.NodeOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.TargetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ObjectTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu thực tế';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc thực tế';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectSampleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectSampleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ReviewerUserID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ReviewerUserName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.SupportUserID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.SupportUserName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserID1.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName1.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đánh giá {0}';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Update', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số Net';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.NetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền hoa hồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CommissionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.GuestCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.BonusSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.RowNumColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc cha';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tạo quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateProcess', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính deadline công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CalculateDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ chối hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chiết khấu NC';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chiết khấu KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chiết khấu dịch vụ KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorKHCUService', @FormID, @LanguageValue, @Language;