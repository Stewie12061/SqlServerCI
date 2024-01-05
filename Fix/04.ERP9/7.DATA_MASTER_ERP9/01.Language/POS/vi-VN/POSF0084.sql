DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF0084'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa phiếu yêu cầu dịch vụ'
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phiếu YCDV';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DVT';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0084.MemberID',  @FormID, @LanguageValue, @Language;