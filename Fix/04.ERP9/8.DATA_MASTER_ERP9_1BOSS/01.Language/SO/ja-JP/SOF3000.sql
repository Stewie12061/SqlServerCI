declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'ja-JP'

SET @FormID = 'SOF3000'
SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'SOF3000.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3000'
SET @LanguageValue = N'Quote';
EXEC ERP9AddLanguage @ModuleID, 'AsoftSO.GRP_BaoCao' , @FormID, @LanguageValue, @Language;

--[Đình Hoà] [09/07/2020] Thêm ngôn ngữ cho group Đơn hàng
SET @LanguageValue = N'Order';
EXEC ERP9AddLanguage @ModuleID, 'AsoftSO.GRP_Donhang' , @FormID, @LanguageValue, @Language;

--[Trọng Kiên] [30/07/2020] Thêm ngôn ngữ cho group Doanh số
SET @LanguageValue = N'Sales';
EXEC ERP9AddLanguage @ModuleID, 'AsoftSO.DoanhSo' , @FormID, @LanguageValue, @Language;

