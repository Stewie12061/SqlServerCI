-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2101- OO
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
SET @FormID = 'HRMF2101'

SET @LanguageValue  = N'Cập nhật lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đào tạo toàn công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.IsAll',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tác đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí ĐT dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ScheduleAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí ĐT dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ScheduleAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí ĐT đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ProposeAmount_MT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí ĐT đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ProposeAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Inherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.FromDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ToDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian đào tạo dự kiến từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.EmployeeID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.EmployeeName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số buổi đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Sessions',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số giờ/buổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.HoursPerSession',  @FormID, @LanguageValue, @Language;