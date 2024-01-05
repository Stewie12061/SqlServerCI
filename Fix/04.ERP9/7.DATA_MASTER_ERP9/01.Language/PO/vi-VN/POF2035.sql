DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2035'
---------------------------------------------------------------
SET @LanguageValue  = N'Chọn yêu cầu báo giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestSubject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian ghi nhận'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.TimeRequest',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời hạn kết thúc'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.DeadlineRequest',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestCustomerID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestStatusName',  @FormID, @LanguageValue, @Language;