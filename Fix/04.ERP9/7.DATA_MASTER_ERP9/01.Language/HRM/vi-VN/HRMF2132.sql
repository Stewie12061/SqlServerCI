-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2132- OO
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
SET @FormID = 'HRMF2132'

SET @LanguageValue  = N'Xem chi tiết ghi nhận chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.AssignedToUser',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'AssignedToUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.CostAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tác đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'RowDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.RowDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ghi nhận chi phí/Lịch ĐT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.SearchTxt',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ghi nhận chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingCostID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingCourseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingSchedule',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin ghi nhận kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh sách nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Employee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.StatusID',  @FormID, @LanguageValue, @Language;
