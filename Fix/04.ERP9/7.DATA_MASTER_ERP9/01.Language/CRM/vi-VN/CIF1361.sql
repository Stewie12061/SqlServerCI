-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1361- CI
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CIF1361';

SET @LanguageValue = N'Cập nhật thông tin hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.TabCIFT13601' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bổ sung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.TabCIFT13602' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.TabCIFT13603' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ Nguyên tệ (trước thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi (trước thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ lục';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.IsAppendixContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APKMaster', @FormID, @LanguageValue, @Language;

-- Đình Hòa [01/02/2021] - Đổi ngôn ngữ(CBD)
IF EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 130)
BEGIN
SET @LanguageValue = N'Lần thanh toán';
END
ELSE
BEGIN
SET @LanguageValue = N'Bước';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán sau (ngày)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.StepDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PaymentPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PaymentAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.StepStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CompleteDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CorrectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PaymentStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Paymented', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ConRefName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ConRef', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.SalePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền VAT nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền VAT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.TransactionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ Nguyên tệ (trước thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi (trước thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.IsInheritSOF2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa yêu cầu mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.IsInheritPOF2031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Contract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VATGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VATGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa báo giá nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.IsInheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PriceListID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PriceListName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Contract', @FormID, @LanguageValue, @Language;


-- Hoài Phong [03/03/2021] Bổ sung ngôn ngũ cho gói  hợp đồng
SET @LanguageValue = N'Gói hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContractPackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.Description.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.ContactorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.DiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.PaymentVATAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ Nguyên tệ (sau thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.MasterVATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi (sau thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.MasterVATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1361.AssignedToUserName', @FormID, @LanguageValue, @Language;