DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2023'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa phiếu báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.ObjectID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.ObjectName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023.OpportunityName',  @FormID, @LanguageValue, @Language;