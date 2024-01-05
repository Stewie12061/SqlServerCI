DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1092';
---------------------------------------------------------------

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.KindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.KindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.SupportDictionarySubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.ThongTinMauYeuCau', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.TimeFeedback', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.TimeFeedbackName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.Title', @FormID, @LanguageValue, @Language;
