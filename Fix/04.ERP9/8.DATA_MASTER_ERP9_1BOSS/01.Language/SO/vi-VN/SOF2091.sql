-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2091- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2091';

SET @LanguageValue = N'Cập nhật đơn hàng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2091.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.ExchangeRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.OrderNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.OrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.SalePrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.DataTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.AdjustQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.AdjustPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.TDescription' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.VoucherNo.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.OrderDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.InventoryID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.InventoryName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.DataType.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.ApprovalNotes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2091.ApprovalDate' , @FormID, @LanguageValue, @Language;

