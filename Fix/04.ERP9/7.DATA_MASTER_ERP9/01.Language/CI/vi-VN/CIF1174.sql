DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1174'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mặt hàng - khác'
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.ETaxID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.ETaxName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 06';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.I10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Varchar01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Varchar02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Varchar03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Varchar04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Varchar05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Notes03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.RefInventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vạch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Barcode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa chịu thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.ETaxID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ quy đỗi ra đơn vị tính thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.ETaxConvertedUnit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tài nguyên chịu thuế tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.NRTClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.NRTClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.NRTClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa dịch vụ chịu thuế TTBD';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.SETID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.SETID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.SETName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ảnh đại diện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1174.Image01ID',  @FormID, @LanguageValue, @Language;

