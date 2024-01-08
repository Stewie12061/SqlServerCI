declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = '00'
SET @Language = 'en-US'


SET @FormID = 'CMNF9003'
SET @LanguageValue = N'Choose Employee';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'EmployeeID';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.EmployeeID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.EmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Department Name';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.DepartmentName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Address' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Tel' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Email' , @FormID, @LanguageValue, @Language;