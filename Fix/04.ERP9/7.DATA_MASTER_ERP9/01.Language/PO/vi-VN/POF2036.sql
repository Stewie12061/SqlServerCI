DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2036'
---------------------------------------------------------------
SET @LanguageValue  = N'Kế thừa dự trù NVL sản xuất'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng THCP'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.ObjectTHCP',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã thành phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.ProductID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên thành phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.ProductName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.ProductQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2036.PDescription',  @FormID, @LanguageValue, @Language;

