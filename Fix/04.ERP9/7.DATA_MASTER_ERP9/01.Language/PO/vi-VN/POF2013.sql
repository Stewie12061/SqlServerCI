DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2013'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh sách năng lực nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số Leadtime_MOQ'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.LeadTimeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.InventoryTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'POF2013.UserName.CB',  @FormID, @LanguageValue, @Language;