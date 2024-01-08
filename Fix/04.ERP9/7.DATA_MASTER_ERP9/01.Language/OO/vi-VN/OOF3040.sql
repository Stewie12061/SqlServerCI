DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'OO';
SET @FormID = 'OOF3040'
---------------------------------------------------------------
SET @LanguageValue  = N'Cập nhật tổ hợp người dùng'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm'
EXEC ERP9AddLanguage @ModuleID, 'OOF3040.GroupName',  @FormID, @LanguageValue, @Language;