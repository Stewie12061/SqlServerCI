DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2021'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 06';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ConditionPayment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PriceListID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PriceListName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SalesManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.APKOpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritPurchase',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.StatusMaster',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa báo giá nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritPOF2041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành bảo trì';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ChooseGuarantee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ChooseAccessory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2027.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2027.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa dự toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritEstimates',  @FormID, @LanguageValue, @Language;


---[Đình Hoà] [27/06/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đã xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đã SO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.IsSO',  @FormID, @LanguageValue, @Language;

---[Đình Hoà] [17/07/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Tên quy cách'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.StandardName.CB',  @FormID, @LanguageValue, @Language;

---[Trọng Kiên] [25/11/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Nhân viên bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana02Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana03Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana04Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana05Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana01ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana01Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana02ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana02Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana03ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana03Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana04ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana04Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana05ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana05Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa bảng tính giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritBoardPricing',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATGroupName',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ContactorName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu nguyên tệ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountAmount',  @FormID, @LanguageValue, @Language;