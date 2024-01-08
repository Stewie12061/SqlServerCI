DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2003'
---------------------------------------------------------------

SET @LanguageValue  = N'In Đơn Hàng Mua'
EXEC ERP9AddLanguage @ModuleID, 'POF2003.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.IsPrint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'In';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.SaveCopy',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'In Skid Label';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.Skid',  @FormID, @LanguageValue, @Language;

--[Phương Thảo][17/06/2023][2023/06/IS/0105] bổ sung Chọn loại in barcode
SET @LanguageValue  = N'Chọn loại in';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.ChooseTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.ChooseTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.ChooseTypeID.CB',  @FormID, @LanguageValue, @Language;