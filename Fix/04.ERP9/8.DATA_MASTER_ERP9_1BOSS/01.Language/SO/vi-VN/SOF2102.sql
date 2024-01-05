-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2102- SO
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
SET @FormID = 'SOF2102';

SET @LanguageValue = N'Chi tiết tiến độ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng (DVT chuẩn)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ConvertedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã giao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ShippedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn lại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.SOrderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 4';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 5';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 6';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 7';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 8';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 9';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 11';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 12';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 13';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 14';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 15';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 16';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 17';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 18';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 19';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 20';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 21';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 22';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 23';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 24';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 25';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 26';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 27';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 28';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 29';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 30';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity30', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tiến độ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ThongTinTienDoGiaoHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết tiến độ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ThongTinChiTietTienDoGiaoHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết tiến độ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.OT2004', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.OT2003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu chạy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ShipStartDate', @FormID, @LanguageValue, @Language;

--17/08/2020 Đình Hoà Thêm ngôn ngữ
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Description', @FormID, @LanguageValue, @Language;