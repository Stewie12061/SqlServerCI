DECLARE @FormID VARCHAR(50)
DECLARE @ModuleID VARCHAR(50)
DECLARE @Language VARCHAR(50)
DECLARE @LanguageValue NVARCHAR(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3011'
SET @LanguageValue = N'Giá bán thực tế so với giá bán chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'SOR3011.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3011'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3011.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3011.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3011.InventoryID' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR3011'
--SET @LanguageValue = N'Từ khách hàng';
--EXEC ERP9AddLanguage @ModuleID, 'SOR3011.FromAccountName' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR3011'
--SET @LanguageValue = N'Đến khách hàng';
--EXEC ERP9AddLanguage @ModuleID, 'SOR3011.ToAccountName', @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR3011'
--SET @LanguageValue = N'Từ nhân viên';
--EXEC ERP9AddLanguage @ModuleID, 'SOR3011.FromSalesManName' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR3011'
--SET @LanguageValue = N'Đến nhân viên';
--EXEC ERP9AddLanguage @ModuleID, 'SOR3011.ToSalesManName' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR3011'
--SET @LanguageValue = N'Từ mặt hàng';
--EXEC ERP9AddLanguage @ModuleID, 'SOR3011.FromInventoryName' , @FormID, @LanguageValue, @Language;

--SET @FormID = 'SOR3011'
--SET @LanguageValue = N'Đến mặt hàng';
--EXEC ERP9AddLanguage @ModuleID, 'SOR3011.ToInventoryName' , @FormID, @LanguageValue, @Language;