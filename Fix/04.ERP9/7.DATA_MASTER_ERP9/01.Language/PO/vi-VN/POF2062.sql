----------------------------------------------------------
-- Script tạo ngôn ngữ POF2062- PO
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
 SET @ModuleID = 'PO';
 SET @FormID = 'POF2062';

SET @LanguageValue = N'Xem chi tiết Đặt containter xuất hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Attacth.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.History.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.SOrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.SOVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SOrderID';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PackedTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu đi';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu đến';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng tàu';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ContQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ChooseOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cảng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Forwarder', @FormID, @LanguageValue, @Language;

delete A00001 where ID = 'POF2062.Closingtime' AND LanguageID = 'vi-VN'

SET @LanguageValue = N'Thời gian đóng';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ClosingTime', @FormID, @LanguageValue, @Language;