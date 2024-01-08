DECLARE @FormID VARCHAR(50)
DECLARE @ModuleID VARCHAR(50)
DECLARE @Language VARCHAR(50)
DECLARE @LanguageValue NVARCHAR(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Chi tiết tình hình báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Nhóm phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.GroupID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.ObjectID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3000'
SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3000.InventoryID' , @FormID, @LanguageValue, @Language;