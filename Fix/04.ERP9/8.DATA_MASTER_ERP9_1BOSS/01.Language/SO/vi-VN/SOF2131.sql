------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2131 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2131';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Cập nhật báo giá kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VouCherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VouCherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.ExchangeRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PaymentTermID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thúc vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Transport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PriceListID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.ConditionPayment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Attention1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Dear' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Attention2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Specification' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diện tích';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Area' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.QuoQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VATGroupName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%Thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thuế GTGT qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm hình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.AttachFileName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lưu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.lblBtnSave' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hủy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.lblCacel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PaymentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PaymentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.PriceListName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.StandardID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.StandardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.VATGroupName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.lblBtnInventoryList' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa báo giá KD';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.IsInherit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự Án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Ana01ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm dự án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.ProjectAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm dự án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2131.Notes.CB' , @FormID, @LanguageValue, @Language;