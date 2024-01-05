-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2082- SO
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
SET @FormID = 'SOF2082';

SET @LanguageValue = N'Xem chi tiết thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng biến phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Dài';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Rộng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Cao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá M2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia tờ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Infor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InforProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InforOffset', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TabCRMT90031', @FormID, @LanguageValue, @Language;
											
SET @LanguageValue = N'Đính kèm';			
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TabCRMT00002', @FormID, @LanguageValue, @Language;
											
SET @LanguageValue = N'Lịch sử'; 			
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InforTotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FileThietKe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.StatusVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApproveCutRollStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt cắt cuộn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApproveWaveStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InfoPhase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Con';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt Con/Bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tờ chạy sóng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐL Gsm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐL Tờ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐL Ram';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐL Kg';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐL M2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.M2', @FormID, @LanguageValue, @Language;

-- Đình Hòa [17/06/2021] : Bổ sung ngôn ngữ
SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.GluingTypeName', @FormID, @LanguageValue, @Language;
