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
SET @FormID = 'HRMF2061'

SET @LanguageValue  = N'Cập nhật ngân sách đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngân sách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.BudgetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toàn công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsAllName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách Quý/Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsBugetYearName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quý'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranQuarter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quý'
EXEC ERP9AddLanguage @ModuleID, 'HRMT2060.IsQuarter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMT2060.IsYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toàn công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsAll',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách Quý/Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranQuarterYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.BudgetAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền còn lại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.RemainBudgetAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = NULL
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsQuarterYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lập ngân sách theo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsBugetYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'{0} Không được là số âm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.NumberNegative',  @FormID, @LanguageValue, @Language;
