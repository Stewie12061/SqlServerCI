DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2031'
---------------------------------------------------------------
SET @LanguageValue  = N'Cập nhật yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày ký HĐ'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ ưu tiên'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đáo hạn'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.DueDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SL tồn kho'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.QuantityInStock',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐVT'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng '
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá yêu cầu mua'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VATGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tiền tệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phương thức'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phương thức'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VATGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VATGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng từ dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InheritPurchareOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.AnaID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.AnaName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Status.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.StatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.FullName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp Người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ApprovingLevel'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.APK'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ApprovalDate'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Specification'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu báo giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.RequestName'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InheritPurchase'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.TaskName'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi nhánh'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana06ID'  ,@FormID, @LanguageValue, @Language;

--Đình Hoà 15/07/2020
--Thay đổi nội dung column Shipdate "Ngày giao hàng" sang "Ngày cần hàng"
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'A00001')
BEGIN
   IF EXISTS (SELECT TOP 1 * FROM A00001 WHERE ID = 'POF2031.ShipDate' AND LanguageID = 'vi-VN')
   UPDATE A00001
   SET Name = N'Ngày cần hàng'
   WHERE ID = 'POF2031.ShipDate' AND LanguageID = 'vi-VN'
END
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana06ID'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa dự trù NVL sản xuất'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InheritEstimatedMaterial'  ,@FormID, @LanguageValue, @Language;

---[Trọng Kiên] [25/11/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Nhân viên bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana02Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana03Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana04Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana05Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana01ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana01Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana02ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana02Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana03ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana03Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana04ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana04Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana05ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Ana05Name.CB',  @FormID, @LanguageValue, @Language;

--Đình Hòa - 26/04/2021 : Bổ sung ngôn ngữ
SET @LanguageValue  = N'Dự trù chi phí'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InheritTentative',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.UnitName.CB',  @FormID, @LanguageValue, @Language;

-- Hoàng Long - 11/08/2023 : Bổ sung trường phòng ban
SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.DepartmentName',  @FormID, @LanguageValue, @Language;

-- Hoàng Long - 13/09/2023 : Bổ sung trường số PO
SET @LanguageValue  = N'Số PO'
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PONumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ConvertedUnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ConvertedUnitName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.DataTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.FormulaDes.CB', @FormID, @LanguageValue, @Language;
