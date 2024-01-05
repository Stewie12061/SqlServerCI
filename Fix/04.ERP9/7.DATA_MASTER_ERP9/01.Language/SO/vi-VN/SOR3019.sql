declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3019'
SET @LanguageValue = N'Báo cáo doanh số bán lẻ (Sell Out)';
EXEC ERP9AddLanguage @ModuleID, 'SOR3019.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3019'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3019.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3019'
SET @LanguageValue = N'Nhân viên (Sale)';
EXEC ERP9AddLanguage @ModuleID, 'SOR3019.SaleID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3019'
SET @LanguageValue = N'Nhà phân phối';
EXEC ERP9AddLanguage @ModuleID, 'SOR3019.DealerID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3019'
SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'SOR3019.SUPID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3019'
SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'SOR3019.ASMID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3019'
SET @LanguageValue = N'Nhóm mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3019.GroupInventoryID' , @FormID, @LanguageValue, @Language;


