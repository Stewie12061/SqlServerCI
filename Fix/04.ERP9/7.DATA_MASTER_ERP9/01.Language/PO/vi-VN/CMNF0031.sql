DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = '00';
SET @FormID = 'CMNF0031'
---------------------------------------------------------------
SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'CMNF0031.UserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'CMNF0031.UserName',  @FormID, @LanguageValue, @Language;
