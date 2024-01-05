declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Báo cáo Chi tiết đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Nhóm phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.GroupID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3002'
SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOR3002.CurrencyName.CB' , @FormID, @LanguageValue, @Language;
