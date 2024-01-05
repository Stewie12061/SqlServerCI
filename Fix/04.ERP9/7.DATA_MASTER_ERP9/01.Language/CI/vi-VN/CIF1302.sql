DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1302'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết loại định mức tồn kho'
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức hàng đặt lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyUserID',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Thông tin mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ThongTinMaDinhMuc',  @FormID, @LanguageValue, @Language;