DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1492'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết mã phân tích đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin mã phân tích đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaTypeName',  @FormID, @LanguageValue, @Language;