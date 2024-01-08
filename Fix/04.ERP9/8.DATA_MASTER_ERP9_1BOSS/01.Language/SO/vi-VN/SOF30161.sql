DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@Name NVARCHAR(4000),
@LanguageValue nvarchar(500)
SET @Language = 'vi-VN'
SET @ModuleID = 'SO'
SET @FormID = 'SOF30161'

SET @LanguageValue = N'Chọn đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF30161.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF30161.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF30161.OrderDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF30161.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF30161.ObjectName' , @FormID, @LanguageValue, @Language;