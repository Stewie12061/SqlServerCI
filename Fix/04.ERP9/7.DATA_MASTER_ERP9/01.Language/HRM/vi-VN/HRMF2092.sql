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
SET @FormID = 'HRMF2092'

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.TrainingProposeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.ProposeAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Description1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Description2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Description3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa YCDT/KHDTDT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Inherit',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.ProposeAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đào tạo từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đào tạo đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã YCDT/KHDTDT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã YCDT/KHDTDT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh sách nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.SubTitle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xem chi tiết đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.InheritName',  @FormID, @LanguageValue, @Language;
