DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CMNF9003'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Fax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng/Ban';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Tel',  @FormID, @LanguageValue, @Language;