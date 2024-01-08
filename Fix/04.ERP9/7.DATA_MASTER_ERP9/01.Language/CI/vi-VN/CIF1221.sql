DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1221'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật vùng khu vực'
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vùng - khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.AreaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vùng - khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.AreaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1221.CreateDate',  @FormID, @LanguageValue, @Language;


