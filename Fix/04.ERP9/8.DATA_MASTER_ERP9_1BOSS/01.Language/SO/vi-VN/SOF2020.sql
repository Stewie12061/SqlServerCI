DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2020'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chủ đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kính gửi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 06';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InventoryType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PaymentTermName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PaymentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'[Button cho mặt hàng]';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.btnChooseInventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng duyệt'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.IsConfirm',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đã tạo đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.IsSO',  @FormID, @LanguageValue, @Language;

--- ĐÌnh Hòa - 06/07/2021 : Bổ sung ngôn ngữ cho Phiếu in Báo giá
SET @LanguageValue  = N'PHIẾU BÁO GIÁ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotesReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chúng tôi hân hạnh cung cấp cho bạn hàng hóa có thời hạn và điều kiện như sau :'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Title1Report',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chúng tôi rất mong được sự ủng hộ của khách hàng đối với các sản phẩm của công ty chúng tôi.'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Title2Report',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thanh toán :'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PayReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghí chú :'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.NoteReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trân trọng!'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.BestRegardsReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'GIÁM ĐỐC'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DirectorReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TelephoneReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã Phiếu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VoucherNoReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DateReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.FromReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ToReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.NameReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công ty'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CompanyReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.EmailReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.AddressReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.FaxReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DescriptionReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại giấy'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.KindOfPaperReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhãn hiệu giấy'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PaperLabelReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.AmountReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PriceReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InheritOrder',  @FormID, @LanguageValue, @Language;