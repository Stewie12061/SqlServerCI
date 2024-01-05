DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1430'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục tuyến giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tuyến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.RouteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tuyến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.RouteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.WareHouseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ca';
EXEC ERP9AddLanguage @ModuleID, 'CIF1430.ShiftName',  @FormID, @LanguageValue, @Language;
