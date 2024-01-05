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
SET @FormID = 'HRMF2103'

SET @LanguageValue  = N'Chọn đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.Department',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.FullName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toàn công ty'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.IsAll',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đào tạo đề xuất'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.ProposeAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.TrainingField',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã yêu cầu đào tạo'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.TrainingProposeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, N'HRMF2103.Description',  @FormID, @LanguageValue, @Language;