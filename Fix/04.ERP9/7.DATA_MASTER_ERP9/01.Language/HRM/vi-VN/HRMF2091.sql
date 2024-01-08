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
SET @FormID = 'HRMF2091'

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.TrainingProposeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.ProposeAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.Description1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.Description2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.Description3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa YCDT/KHDTDT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.Inherit',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.ProposeAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đào tạo từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đào tạo đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã YCDT/KHDTDT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã YCDT/KHDTDT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.EmployeeID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.EmployeeName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cập nhật đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toàn công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.IsAll',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã YCDT/KHDTDT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.FromDate.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2091.ToDate.CB',  @FormID, @LanguageValue, @Language;