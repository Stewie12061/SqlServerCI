-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2102- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2102'

SET @LanguageValue  = N'Xem chi tiết lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Description1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Description2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Description3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đào tạo toàn công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.IsAll',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tác đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí ĐT dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ScheduleAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí ĐT dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ScheduleAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.FromDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ToDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingCourseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingCourseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingCoursID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TrainingCoursName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ProposeAmount_MT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ProposeAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian đào tạo (dự kiến) từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh sách nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabEmployee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2102.AssignedToUserName',  @FormID, @LanguageValue, @Language;
