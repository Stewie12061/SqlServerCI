declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF3013'
SET @LanguageValue = N'Báo cáo so sánh doanh số mặt hàng theo tháng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3013.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3013'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF3013.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3013'
SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF3013.InventoryID' , @FormID, @LanguageValue, @Language;
