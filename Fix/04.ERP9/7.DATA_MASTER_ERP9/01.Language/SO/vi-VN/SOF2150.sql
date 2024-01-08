------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2150 - CRM 
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
SET @FormID = 'SOF2150';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Danh mục đơn hàng bán lẻ - Sell out';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.OrderDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.ShipDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.VATObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.RouteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.IsPrinted' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.PriceListID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.ShipAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị trước thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.TotalUnVATAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Số tiền thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.TotalPayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.IsConfirm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.DescriptionConfirm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.IsConfirmName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng giao hộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.IsCommit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá trị đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.TotalAmount' , @FormID, @LanguageValue, @Language;

-- Đình Hòa [29/03/2021] - Thêm ngôn ngữ
SET @LanguageValue = N'Đã thu tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.IsCollectedMoney' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.IsExportOrder' , @FormID, @LanguageValue, @Language;

-- Minh Hiếu [10/02/2022] - Thêm ngôn ngữ
SET @LanguageValue = N'Người bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.SalesManID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.SalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2150.IsWholeSale' , @FormID, @LanguageValue, @Language;