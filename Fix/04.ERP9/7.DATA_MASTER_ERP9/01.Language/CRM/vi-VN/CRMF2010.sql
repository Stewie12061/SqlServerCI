declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'

SET @FormID = 'CRMF2010'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.OrderDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.VoucherNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.ObjectID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.ObjectName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.Address' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.EmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.OrderStatusName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.ShipDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhân viên giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.DeliveryEmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.RouteName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.Coordi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.Notes' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú KTBH xử lý';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.Description01' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ý kiến duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.DescriptionConfirm' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.NotesQuantity' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.Tel' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Loại khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.O04ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2010.OrderDay' , @FormID, @LanguageValue, @Language;