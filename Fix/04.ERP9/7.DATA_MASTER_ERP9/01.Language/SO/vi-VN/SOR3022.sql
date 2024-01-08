declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3022'
SET @LanguageValue = N'Báo cáo chương trình khuyến mãi theo đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3022.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3022'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3022.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3022'
SET @LanguageValue = N'Nhóm đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3022.Code' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3022'
SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3022.CustomerID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3022'
SET @LanguageValue = N'Chương trình khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'SOR3022.Promote' , @FormID, @LanguageValue, @Language;
