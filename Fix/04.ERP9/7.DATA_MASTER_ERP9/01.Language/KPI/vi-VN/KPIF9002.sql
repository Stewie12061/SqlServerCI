DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF9002'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu phòng ban/công ty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.MainTargetID',  @FormID, @LanguageValue, @Language;


