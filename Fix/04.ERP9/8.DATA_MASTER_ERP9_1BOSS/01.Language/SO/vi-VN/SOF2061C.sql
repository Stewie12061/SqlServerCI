DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2061C'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật phiếu báo giá (KHCU)'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ConditionPayment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PriceListID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PriceListName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.SalesManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.APKOpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritPurchase',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.StatusMaster',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa báo giá nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritPOF2041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành bảo trì';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ChooseGuarantee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ChooseAccessory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số tổng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TotalCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Factor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ProfileCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cước vận chuyển Nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InternalShipCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxImport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hải quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CustomsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm định thông quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CustomsInspectionCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí T/T';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TT_Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LC_Open',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LC_Receice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành tạm ứng/TTHD/Bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.WarrantyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InformType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxFactor1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxFactor2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.GuestsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khảo sát';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.SurveyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PlusCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TotalCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa NC';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritNC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa KHCU';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritKHCU',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaskName',  @FormID, @LanguageValue, @Language;