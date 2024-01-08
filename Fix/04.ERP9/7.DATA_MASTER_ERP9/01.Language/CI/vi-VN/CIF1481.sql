DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1481'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mã phân tích mua và bán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.TabSaleOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích đơn hàng mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.TabPurchaseOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa (tiếng Anh)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.IsUsed',  @FormID, @LanguageValue, @Language;