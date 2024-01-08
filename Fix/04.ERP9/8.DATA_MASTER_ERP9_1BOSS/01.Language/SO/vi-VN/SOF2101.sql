-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2101- SO
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
SET @FormID = 'SOF2101';

SET @LanguageValue = N'Cập nhật tiến độ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng (DVT chuẩn)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.ConvertedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã giao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.ShippedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn lại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.SOrderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 4';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 5';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 6';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 7';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 8';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 9';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 11';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 12';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 13';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 14';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 15';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 15';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 17';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 18';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 19';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 20';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.FormToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 21';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 22';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 23';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 24';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 25';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 26';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 27';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 28';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 29';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 30';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.Quantity30', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.DeliveryPostalCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.DeliveryAddress.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu chạy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2101.ShipStartDate', @FormID, @LanguageValue, @Language;