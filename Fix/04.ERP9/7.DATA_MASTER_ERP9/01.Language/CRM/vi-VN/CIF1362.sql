-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1362- CI
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
SET @FormID = 'CIF1362';

SET @LanguageValue = N'Xem thông tin hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinHopDong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinThanhToan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bổ sung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinBoSung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinHangHoa' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ lục';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.IsAppendixContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán sau (ngày)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CompleteDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CorrectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Paymented', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConRef', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConRefName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.SalePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền VAT nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền VAT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TransactionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.IsInheritSOF2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ lục';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.InheritContractID', @FormID, @LanguageValue, @Language;

---17/08/2020 Đình Hoà : Thêm ngôn ngữ
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ToDate', @FormID, @LanguageValue, @Language;

-- Hoài Phong [03/03/2021] Bổ sung ngôn ngũ cho gói  hợp đồng
SET @LanguageValue = N'Gói hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractPackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.DiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentVATAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ nguyên tệ sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.MasterVATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.MasterVATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PriceListName', @FormID, @LanguageValue, @Language;