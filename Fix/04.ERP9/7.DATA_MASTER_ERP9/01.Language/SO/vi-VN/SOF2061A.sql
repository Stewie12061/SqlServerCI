DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2061A'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật phiếu báo giá (NC)'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Ana10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Varchar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ConditionPayment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phương thức'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PriceListID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PriceListName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.SalesManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.APKOpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InheritPurchase',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.StatusMaster',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa báo giá nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InheritPOF2041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành bảo trì';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ChooseGuarantee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ChooseAccessory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số tổng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TotalCoefficient',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.Factor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.ProfileCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cước vận chuyển Nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InternalShipCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TaxImport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hải quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.CustomsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm định thông quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.CustomsInspectionCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí T/T';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TT_Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.LC_Open',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.LC_Receice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành tạm ứng/TTHD/Bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.WarrantyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InformType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TaxFactor1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TaxFactor2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TaxCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.GuestsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khảo sát';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.SurveyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.PlusCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TotalCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa NC';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InheritNC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa KHCU';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.InheritKHCU',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061A.TaskName',  @FormID, @LanguageValue, @Language;