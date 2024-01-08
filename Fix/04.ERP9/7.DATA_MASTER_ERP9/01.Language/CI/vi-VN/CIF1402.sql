DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1402'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết đơn vị tính chuyển đổi'
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.ConversionFactor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.DataType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.FormulaDes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ví dụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Example',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.ConvertUnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin đơn vị tính chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.ThongTinDonViTinhCD',  @FormID, @LanguageValue, @Language;