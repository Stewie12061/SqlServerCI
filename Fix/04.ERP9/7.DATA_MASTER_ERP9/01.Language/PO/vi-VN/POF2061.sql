----------------------------------------------------------
-- Script tạo ngôn ngữ POF2061- PO
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
 SET @FormID = 'POF2061';

SET @LanguageValue = N'Cập nhật Đặt containter xuất hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.SOrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.SOVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SOrderID';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PackedTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu đi';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu đến';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian đóng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ClosingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng tàu';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ContQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ChooseOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cảng';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Forwarder', @FormID, @LanguageValue, @Language;



