DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'M';
SET @FormID = 'MF2163'
---------------------------------------------------------------

SET @LanguageValue  = N'In Lệnh Sản Xuất'
EXEC ERP9AddLanguage @ModuleID, 'MF2163.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.IsPrint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'In';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.SaveCopy',  @FormID, @LanguageValue, @Language;
