-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2111BB- SO
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
SET @FormID = 'CRMF2111B';

SET @LanguageValue = N'Cập nhật dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vốn / Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá M2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.InheritCRMT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia tờ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (tờ)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (M2)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DeliveryAddressID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DeliveryAddressName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Code.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.RunPaperID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.RunPaperName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PhaseName.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bao gồm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tờ chạy sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SemiProduct.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SemiProductName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitPrice.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.GluingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.NoteDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí Nguyên vật liệu & Nhân công (chưa điều chỉnh)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PriceListID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PriceListName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.SetupTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.NormsType ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.LossAmount ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.LossValue ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.DivisionID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.InventoryID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.InventoryTypeID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu'
EXEC ERP9AddLanguage @ModuleID, 'TabSOT2184', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các loại chi phí khác'
EXEC ERP9AddLanguage @ModuleID, 'TabSOT2185', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá bình quân gia quyền'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111B.UnitPriceAverage ', @FormID, @LanguageValue, @Language;
