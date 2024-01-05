DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2001'
---------------------------------------------------------------
SET @LanguageValue  = N'Ngày thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cập nhật đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số'
EXEC ERP9AddLanguage @ModuleID, 'POF2003Title.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PurchaseManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PurchaseManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.LastModifyUserDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsPicking',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đáo hạn';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DueDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐKTT'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phương thức'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phương thức'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kho'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đáo hạn';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DueDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã PL đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên PL đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PriceListID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PriceListName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa kế hoạch mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsInheritPP' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderStatus.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa yêu cầu mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InheritPurchase' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Specification' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoàn tất';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Finish' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Thêm nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Danh_sach_mat_hang',  @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Status',  @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ApprovalNotes',  @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Status.CB',  @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.StatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa báo giá nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InheritPOF2041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đơn hàng gia công';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InheritOutSource',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.StandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InheritSaleOrders', @FormID, @LanguageValue, @Language;

---[Trọng Kiên] [25/11/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Nhân viên bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana02Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana03Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana04Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana05Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana01ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana01Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana02ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana02Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana03ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana03Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana04ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana04Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana05ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana05Name.CB',  @FormID, @LanguageValue, @Language;

--==================

SET @LanguageValue  = N'% Thuế XNK'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ImportAndExportDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế XNK'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IExportDutiesConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Thuế tự vệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.SafeguardingDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế tự vệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.SafeguardingDutiesConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Thuế khác'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DifferentDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế khác'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DifferentDutiesConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng thuế '
EXEC ERP9AddLanguage @ModuleID, 'POF2001.SumDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ContQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí kéo 1 cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CostTowing',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí nguyên tệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CostOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CostConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung chi phí '
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DescriptionCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá thành sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ProductPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiếu khấu'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DiscountOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ReceivedDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ItemTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DiscountTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền VAT'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng cộng'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderTotal',  @FormID, @LanguageValue, @Language;

-- Hoàng Long - 13/09/2023 : Bổ sung trường số PO
SET @LanguageValue  = N'Số PO'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PONumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ConvertedUnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ConvertedUnitName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DataTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.FormulaDes.CB', @FormID, @LanguageValue, @Language;
