DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1431'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật tuyến giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tuyến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.RouteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tuyến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.RouteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.WareHouseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ca';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.ShiftID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ca';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.ShiftName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ca';
EXEC ERP9AddLanguage @ModuleID, 'CIF1431.ShiftID',  @FormID, @LanguageValue, @Language;