-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2092- SO
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
SET @FormID = 'SOF2092';

SET @LanguageValue = N'Xem chi tiết đơn hàng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2092.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2092.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.ExchangeRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.OrderNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.OrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.SalePrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.DataTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.AdjustQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.AdjustPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.TDescription' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.TabInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết đơn hàng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.TabInfo1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.TabCMNT90051' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SOF2092.TabCRMT00003' , @FormID, @LanguageValue, @Language;