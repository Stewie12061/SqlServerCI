DECLARE @FormID VARCHAR(50)
DECLARE @ModuleID VARCHAR(50)
DECLARE @Language VARCHAR(50)
DECLARE @LanguageValue NVARCHAR(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Báo cáo tổng hợp đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.ObjectID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.OrderStatus' , @FormID, @LanguageValue, @Language;