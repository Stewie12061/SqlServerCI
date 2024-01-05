declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'

SET @FormID = 'CRMF2020'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.VoucherDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.VoucherNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.SVoucherNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.VATObjectName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.Address' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.EmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.RouteName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhân viên giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.DeliveryEmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.Description' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú KTBH xử lý';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.Description01' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.Tel' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.NotesQuantity' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Trạng thái thủ kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeWareHouseID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Trạng thái thủ quỹ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeCashierID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái thủ kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeWareHouseName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Trạng thái thủ quỹ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeCashierName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.ShipDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.OrderDay' , @FormID, @LanguageValue, @Language;