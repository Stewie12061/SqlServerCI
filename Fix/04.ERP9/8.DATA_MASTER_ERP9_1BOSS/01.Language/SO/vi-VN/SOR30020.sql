declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Tổng hợp đơn hàng bán theo loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30020'
SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOR30020.InventoryTypeID' , @FormID, @LanguageValue, @Language;
