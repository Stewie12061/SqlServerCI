DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1220'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục vùng khu vực'
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vùng - khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.AreaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vùng - khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.AreaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1220.CreateDate',  @FormID, @LanguageValue, @Language;


