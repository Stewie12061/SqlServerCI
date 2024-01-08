-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2131- OO
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
SET @FormID = 'HRMF2131'

SET @LanguageValue  = N'Cập nhật ghi nhận chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.AssignedToUser',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'AssignedToUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm file'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đào tạo thực tế'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.CostAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tác đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'RowDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.RowDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ghi nhận chi phí/Lịch ĐT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.SearchTxt',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ghi nhận chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingCostID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingCourseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian đào tạo thực tế'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingSchedule',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;

