DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2014'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật năng lực nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số Leadtime_MOQ'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.LeadTimeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DVT'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng đặt hàng (MOQ)'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian chờ giao hàng (Ngày)'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.DeliverDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên 1'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Priority1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên 2'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Priority2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên 3'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Priority3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Priority.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.PriorityName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Thêm nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Danh_sach_mat_hang',  @FormID, @LanguageValue, @Language;