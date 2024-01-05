declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Báo cáo phân tích chi tiết doanh số bán hàng theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Mã PT khu vực';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.AreaAnaTypeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Mã PT nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.SaleAnaTypeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Mã PT khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.CustomerAnaTypeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.ObjectID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3025'
SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3025.InventoryID' , @FormID, @LanguageValue, @Language;
