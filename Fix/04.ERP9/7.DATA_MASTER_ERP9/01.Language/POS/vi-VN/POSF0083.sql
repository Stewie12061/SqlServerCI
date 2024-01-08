DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF0083'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa phiếu bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberIDSearch',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberIDSearchOKIA',  @FormID, @LanguageValue, @Language;


