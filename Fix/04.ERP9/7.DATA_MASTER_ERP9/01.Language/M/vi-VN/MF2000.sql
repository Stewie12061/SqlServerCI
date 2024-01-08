DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'M';
SET @FormID = 'MF0000'
---------------------------------------------------------------

SET @LanguageValue  = N'Thiết lập hệ thống'
EXEC ERP9AddLanguage @ModuleID, 'MF0000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Sắp xếp cont'
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherSortCont',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Tính thùng đóng gói'
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherParking',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Đóng gói giao khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherParkingRequest',  @FormID, @LanguageValue, @Language;