DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9018';
---------------------------------------------------------------

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.KindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.KindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.SupportDictionarySubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.TimeFeedback', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.TimeFeedbackName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.Title', @FormID, @LanguageValue, @Language;
