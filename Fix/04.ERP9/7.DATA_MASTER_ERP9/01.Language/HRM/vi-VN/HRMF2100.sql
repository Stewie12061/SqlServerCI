-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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
SET @FormID = 'HRMF2100'


SET @LanguageValue  = N'Danh mục lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ScheduleAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lịch ĐT/ Khóa ĐT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.SearchTxt',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tác đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giờ đào tạo cụ thể'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.SpecificHours',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseName.CB',  @FormID, @LanguageValue, @Language;