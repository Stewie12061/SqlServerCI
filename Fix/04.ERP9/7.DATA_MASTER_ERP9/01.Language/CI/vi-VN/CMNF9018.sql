DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CMNF9018'
---------------------------------------------------------------

SET @LanguageValue  = N'Màn hình truy vấn ngược'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9018.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9018.BusinessREL',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9018.BusinessRELName',  @FormID, @LanguageValue, @Language;