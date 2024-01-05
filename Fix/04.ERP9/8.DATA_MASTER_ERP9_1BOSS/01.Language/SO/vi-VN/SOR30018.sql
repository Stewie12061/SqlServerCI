declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR30018'
SET @LanguageValue = N'Tổng hợp tình hình giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30018'
SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30018'
SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30018'
SET @LanguageValue = N'Nhóm phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.GroupID' , @FormID, @LanguageValue, @Language;

