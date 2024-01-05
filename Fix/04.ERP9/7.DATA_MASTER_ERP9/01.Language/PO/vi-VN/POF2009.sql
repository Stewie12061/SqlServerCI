DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2009'



---------------------------------------------------------------
--==============================================================
--Minh Hiếu thêm ngôn ngữ cho table OT3007

SET @LanguageValue = N'Thông tin vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.TabOT3007', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng container'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.QuantityContainer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InvoiceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vận đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.BillOfLadingNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn thông quan'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ClearanceExpirationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tàu chạy'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DepartureDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tàu đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ArrivalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian được miễn phí lưu cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DateFreeCont',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian được miễn phí lưu bãi'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DateFreePlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thanh toán tiền hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.PaymentDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hồ sơ đăng ký chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CRMajorsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số giấy đăng chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CRMajorsNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày lấy mẫu kiểm tra chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DateInspection',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp quy'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.LegalNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng nhận hợp quy'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CertificateLegalNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng thư'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CertificateNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kéo cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.TowingDate',  @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày lấy mẫu kiểm tra chuyên ngành';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InspectionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày xếp hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ShipDate',  @FormID, @LanguageValue, @Language;

--=========================================================
SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho giữ chỗ'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giữ chỗ'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.IsPicking',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Thuế XNK'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ImportAndExportDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế XNK'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.IExportDutiesConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Thuế chống bán phá giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.SafeguardingDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế chống bán phá giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.SafeguardingDutiesConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Thuế khác'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DifferentDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế khác'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DifferentDutiesConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng thuế'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.SumDuties',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ContQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí kéo 1 cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CostTowing',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí kéo(nguyên tệ)'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CostOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí kéo(quy đổi)'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CostConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung chi phí'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DescriptionCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá niêm yết hải quan'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ExchangeRateCustoms',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sản xuất xong'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.FinishedProductionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cảng nhập'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ImportPort',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập cảng'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ImportPortDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhập kho dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DeliveryAddressDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế NK dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ExpectedImportTax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế TTDB dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ExpectedSpecialConsumptionTax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ExpectedValueAddedTax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng thuế dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.EstimatedTotalTax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Cảng nhập'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2009.AnaID.CB',  @FormID, @LanguageValue, @Language;
