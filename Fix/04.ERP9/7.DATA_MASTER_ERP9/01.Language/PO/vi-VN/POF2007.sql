DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2007'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn mẫu báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'POF2007.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mẫu 1';
EXEC ERP9AddLanguage @ModuleID, 'POF2007.Ver1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mẫu 2';
EXEC ERP9AddLanguage @ModuleID, 'POF2007.Ver2',  @FormID, @LanguageValue, @Language;



