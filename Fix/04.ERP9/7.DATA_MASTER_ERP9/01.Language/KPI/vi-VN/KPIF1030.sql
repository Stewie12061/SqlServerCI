DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1030'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục nguồn đo'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1030.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1030.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1030.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1030.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1030.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1030.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1030.Disabled',  @FormID, @LanguageValue, @Language;


