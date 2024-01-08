DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'ja-JP';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1400'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục đơn vị tính chuyển đổi'
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.ConvertUnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.ConversionFactor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.DataType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.FormulaDes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ví dụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Example',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.LastModifyDate',  @FormID, @LanguageValue, @Language;