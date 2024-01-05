DECLARE @FormID VARCHAR(50)
DECLARE @ModuleID VARCHAR(50)
DECLARE @Language VARCHAR(50)
DECLARE @LanguageValue NVARCHAR(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'
SET @FormID = 'SOR30018'

SET @LanguageValue = N'Tổng hợp tình hình giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.GroupID' , @FormID, @LanguageValue, @Language;