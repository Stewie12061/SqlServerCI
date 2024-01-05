DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2061B'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật phiếu báo giá (Sale)'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ConditionPayment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PriceListID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PriceListName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.SalesManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.APKOpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritPurchase',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.StatusMaster',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa báo giá nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritPOF2041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành bảo trì';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ChooseGuarantee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ChooseAccessory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số tổng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TotalCoefficient',  @FormID, @LanguageValue, @Language;





SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Factor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ProfileCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cước vận chuyển Nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InternalShipCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxImport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hải quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CustomsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm định thông quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CustomsInspectionCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí T/T';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TT_Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LC_Open',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LC_Receice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành tạm ứng/TTHD/Bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.WarrantyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InformType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 1(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxFactor1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 2(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxFactor2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.GuestsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khảo sát';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.SurveyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'GT cộng thêm (hệ số)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PlusCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TotalCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa NC';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritNC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa KHCU';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritKHCU',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoa hồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PlusSaleCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaskName',  @FormID, @LanguageValue, @Language;