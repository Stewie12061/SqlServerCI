declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3020'
SET @LanguageValue = N'Báo cáo doanh số bán sỉ (Sell In)';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3020'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3020'
SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.Code' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3020'
SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3020'
SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.CustomerID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3020'
SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.SUPID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3020'
SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.ASMID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3020'
SET @LanguageValue = N'Đã khai báo';
EXEC ERP9AddLanguage @ModuleID, 'SOR3020.IsDeclare' , @FormID, @LanguageValue, @Language;


