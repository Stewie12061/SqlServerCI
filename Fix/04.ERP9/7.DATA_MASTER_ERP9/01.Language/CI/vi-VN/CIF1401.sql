DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1401'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật đơn vị tính chuyển đổi'
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.ConversionFactor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.OperatorName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cách tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cách tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaDes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Operator.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.OperatorName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cách tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.StandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.LastModifyDate',  @FormID, @LanguageValue, @Language;