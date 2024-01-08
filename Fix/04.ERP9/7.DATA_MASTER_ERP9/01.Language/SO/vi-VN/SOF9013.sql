DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF9013'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giai đoạn bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.StageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn gốc';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.NextActionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.ExpectAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.StartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày dự kiến kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.ExpectedCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hành động';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.NextActionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SOF9013.IsCommon',  @FormID, @LanguageValue, @Language;



