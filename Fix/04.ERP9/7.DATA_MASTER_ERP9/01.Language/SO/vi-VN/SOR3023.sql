declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3023'
SET @LanguageValue = N'Báo cáo tổng hợp doanh số treo tường kênh phân phối RAC';
EXEC ERP9AddLanguage @ModuleID, 'SOR3023.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3023'
SET @LanguageValue = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOR3023.FromDate' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3023'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3023.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3023'
SET @LanguageValue = N'Vùng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3023.OID' , @FormID, @LanguageValue, @Language;
