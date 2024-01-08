DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1280'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục điều khoản thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.PaymentTermName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đáo hạn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.IsDueDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại đáo hạn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DueType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DueDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chốt sổ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.CloseDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vào ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.TheDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Của tháng thứ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.TheMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DiscountType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số ngày hưởng chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DiscountDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ chiết khấu được hưởng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DiscountPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.LastModifyUserID',  @FormID, @LanguageValue, @Language;


