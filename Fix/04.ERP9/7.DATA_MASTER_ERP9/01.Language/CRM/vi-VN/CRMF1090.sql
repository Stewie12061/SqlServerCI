DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1090';
---------------------------------------------------------------

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.KindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.KindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.KindID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.KindName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.SupportDictionarySubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.TimeFeedback', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.TimeFeedbackName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1090.Title', @FormID, @LanguageValue, @Language;
