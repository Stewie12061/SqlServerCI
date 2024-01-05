declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Chọn nhân viên cấp ADMIN';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.Address' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.Email' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9016'
SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9016.Tel' , @FormID, @LanguageValue, @Language;


