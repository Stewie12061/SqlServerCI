DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2015'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem thông tin năng lực nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số Leadtime_MOQ'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.LeadTimeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DVT'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng đặt hàng (MOQ)'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian chờ giao hàng (leadtime)'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.DeliverDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.TabThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.TabThongTinChiTiet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'POF2015.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năng lực nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'A00.POT2013',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết năng lực nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'A00.POT2014',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.APK.PO',  @FormID, @LanguageValue, @Language;


