DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2173'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa phiếu yêu cầu dịch vụ'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2173.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2173.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2173.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2173.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2173.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2173.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2173.SumAmount',  @FormID, @LanguageValue, @Language;


