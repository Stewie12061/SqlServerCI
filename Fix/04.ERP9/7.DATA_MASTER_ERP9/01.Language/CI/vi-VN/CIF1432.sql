DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1432'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết tuyến giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tuyến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.RouteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tuyến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.RouteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.WareHouseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tuyến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.ThongTinTuyen',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.GhiChu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.DinhKem',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ca';
EXEC ERP9AddLanguage @ModuleID, 'CIF1432.ShiftName',  @FormID, @LanguageValue, @Language;