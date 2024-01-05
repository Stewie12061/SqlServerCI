DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1001'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật từ điển năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.AppraisalDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.AppraisalDictionaryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.AppraisalGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.LevelStandardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.LevelStandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1001.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;