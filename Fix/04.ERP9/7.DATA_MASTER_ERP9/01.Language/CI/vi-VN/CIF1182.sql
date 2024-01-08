DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1182'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết bộ định mức KIT'
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.KITID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.KITName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bộ định KIT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.ThongTinBoDinhKit',  @FormID, @LanguageValue, @Language;



SET @LanguageValue  = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'TabAT1324',  @FormID, @LanguageValue, @Language;



