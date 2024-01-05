-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2111- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2111';

SET @LanguageValue = N'Cập nhật dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá M2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InheritCRMT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia tờ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (tờ)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (M2)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryAddressID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryAddressName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Code.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunPaperID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunPaperName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseName.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bao gồm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tờ chạy sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProduct.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProductName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitPrice.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.GluingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.NoteDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MaterialGroupID', @FormID, @LanguageValue, @Language;