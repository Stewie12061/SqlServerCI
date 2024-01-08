DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2033'
---------------------------------------------------------------
SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng từ dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ProjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCOrderNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCModel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng sản xuất'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCMadeby',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCInvenType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xuất xứ'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCMadeIn',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đầu mục thiết bị'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCEquipment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.Project',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ProjectName',  @FormID, @LanguageValue, @Language;

