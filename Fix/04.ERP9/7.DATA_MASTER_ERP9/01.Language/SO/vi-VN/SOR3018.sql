declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

DELETE from A00001 where FormID = 'SOR3018'

SET @FormID = 'SOR3018'
SET @LanguageValue = N'Báo cáo tổng doanh số bán hàng của nhân viên theo ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOR3018.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3018'
SET @LanguageValue = N'Báo cáo tổng doanh số bán hàng của nhân viên theo ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOF3018.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3018'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3018.DivisionID' , @FormID, @LanguageValue, @Language;


SET @FormID = 'SOR3018'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3018.FromSalesManName' , @FormID, @LanguageValue, @Language;


SET @FormID = 'SOR3018'
SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'SOR3018.DepartmentID' , @FormID, @LanguageValue, @Language;

