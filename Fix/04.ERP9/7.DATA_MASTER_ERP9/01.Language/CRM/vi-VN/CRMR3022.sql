declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMR3022'

SET @LanguageValue = N'Báo cáo khách hàng không tương tác với dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3022.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3022.ReportDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3022.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3022.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3022.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3022.InteractDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3022.CheckInteract' , @FormID, @LanguageValue, @Language;