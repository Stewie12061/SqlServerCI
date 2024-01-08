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
SET @FormID = 'HRMF2062'

SET @LanguageValue  = N'Xem chi tiết ngân sách đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngân sách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.BudgetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toàn công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsAllName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách theo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsBugetYearName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quý'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranQuarter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toàn công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsAll',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách Quý/Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranQuarterYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.BudgetAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền còn lại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.RemainBudgetAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = NULL
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsQuarterYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lập ngân sách theo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsBugetYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin ngân sách đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TabCRMT00002',  @FormID, @LanguageValue, @Language;