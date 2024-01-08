declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3021'
SET @LanguageValue = N'Doanh số Sale In';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3021'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3021'
SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.Code' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3021'
SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3021'
SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.DealerID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3021'
SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.SUPID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3021'
SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.ASMID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3021'
SET @LanguageValue = N'Đã khai báo';
EXEC ERP9AddLanguage @ModuleID, 'SOR3021.IsDeclare' , @FormID, @LanguageValue, @Language;


