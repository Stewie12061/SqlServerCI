DECLARE @FormID VARCHAR(50)
DECLARE @ModuleID VARCHAR(50)
DECLARE @Language VARCHAR(50)
DECLARE @LanguageValue NVARCHAR(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Tổng hợp tình hình báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.ObjectID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.Report1' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.Report2' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.Report3' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR30011'
--SET @LanguageValue = N'Từ khách hàng';
--EXEC ERP9AddLanguage @ModuleID, 'SOR30011.FromAccountName' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR30011'
--SET @LanguageValue = N'Đến khách hàng';
--EXEC ERP9AddLanguage @ModuleID, 'SOR30011.ToAccountName', @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR30011'
--SET @LanguageValue = N'Từ nhân viên';
--EXEC ERP9AddLanguage @ModuleID, 'SOR30011.FromSalesManName' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR30011'
--SET @LanguageValue = N'Đến nhân viên';
--EXEC ERP9AddLanguage @ModuleID, 'SOR30011.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Trang thái';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn mẫu báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.GroupSOR30011' , @FormID, @LanguageValue, @Language;