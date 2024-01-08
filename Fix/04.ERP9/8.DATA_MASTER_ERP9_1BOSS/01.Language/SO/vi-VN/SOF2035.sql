declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF2035'
SET @LanguageValue = N'Kế thừa dữ liệu từ App Mobile';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.SaleEmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.OrderNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.OrderDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.SaleEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.ImpactLevelName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.DiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.DiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2035.OrderQuantity' , @FormID, @LanguageValue, @Language;
