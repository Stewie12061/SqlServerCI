DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF9001'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn từ điển chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã từ điển chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.TargetsDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên từ điển chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.TargetsDictionaryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.TargetsGroupID',  @FormID, @LanguageValue, @Language;


