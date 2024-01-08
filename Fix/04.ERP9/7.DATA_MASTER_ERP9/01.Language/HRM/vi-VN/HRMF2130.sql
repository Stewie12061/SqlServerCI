-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2130- HRM
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
SET @FormID = 'HRMF2130'

SET @LanguageValue  = N'Danh mục ghi nhận chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.AssignedToUser',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CostAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tác đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'RowDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.RowDate',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Mã ghi nhận chi phí/Lịch ĐT'
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.SearchTxt',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ghi nhận chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingCostID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingCourseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingSchedule',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;

