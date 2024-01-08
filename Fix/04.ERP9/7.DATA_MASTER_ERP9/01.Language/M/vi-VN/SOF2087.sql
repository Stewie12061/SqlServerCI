-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2087- M
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
SET @ModuleID = 'M';
SET @FormID = 'SOF2087';

SET @LanguageValue = N'Chọn phiếu thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Inventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị BTP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.AssembleValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia tờ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tờ chạy sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Sheets)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (M2)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.PhaseTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT thông số máy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.UnitIDDetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian quy trình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.RoutingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian định mức';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lao động';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2087.DeliveryAddressName', @FormID, @LanguageValue, @Language;