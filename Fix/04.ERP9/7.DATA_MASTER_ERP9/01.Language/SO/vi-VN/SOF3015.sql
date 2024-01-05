declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF3015'
SET @LanguageValue = N'Báo cáo kế hoạch bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3015.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3015'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF3015.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3015'
SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3015.InventoryID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3015'
SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF3015.YearPlan' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3015'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3015.ObjectID' , @FormID, @LanguageValue, @Language;