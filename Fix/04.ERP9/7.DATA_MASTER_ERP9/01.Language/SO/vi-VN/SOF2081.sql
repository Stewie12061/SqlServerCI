-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2081- CRM
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
SET @FormID = 'SOF2081';

SET @LanguageValue = N'Cập nhật thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.TabSOT2081', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rã nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.TabSOT2082', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng biến phí ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá M2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia tờ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Sheets)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (M2)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryAddressID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryAddressName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Code.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunPaperID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunPaperName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovedPerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tờ chạy sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProduct.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProductName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bao gồm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt cắt cuộn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveWaveStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveCutRollStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Assemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.GluingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại BTP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái duyệt cắt cuộn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveCutRollStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt cắt cuộn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveCutRollStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái duyệt sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveWaveStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveWaveStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài (Khổ file cpt/bản in)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng (Khổ file cpt/bản in)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bằng (Khổ file cpt/bản in)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT (Khổ file cpt/bản in)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bao gồm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu nội dung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu màu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu MT sx ký';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.NodeTypeName', @FormID, @LanguageValue, @Language;