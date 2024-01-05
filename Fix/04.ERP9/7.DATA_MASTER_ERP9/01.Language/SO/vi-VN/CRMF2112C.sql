-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2112C- SO
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
SET @FormID = 'CRMF2112C';

SET @LanguageValue = N'Xem chi tiết dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.LengthView', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.WidthView', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Cao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.HeightView', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá M2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia tờ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Infor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.InforProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin in sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.InforOffset', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.InforTotalVariableFee', @FormID, @LanguageValue, @Language;
------------
SET @LanguageValue = N'Mẫu nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu màu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu MT sx ký';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ file /bản in (Dài)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ file/bản in (Rộng)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ file ctp/bản in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bao gồm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Include', @FormID, @LanguageValue, @Language;

----- 30/12/2020: Trọng Kiên: Bổ sung ngôn ngữ group công đoạn

SET @LanguageValue = N'Thông tin công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.InforPhase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Con';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tờ chạy Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng Gsm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng  Tờ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng Ram';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng  Kg';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng M2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.GluingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.NoteDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá bình quân gia quyền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.UnitPriceAverage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TabCRMT2114', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi phí khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112C.TabCRMT2115', @FormID, @LanguageValue, @Language;
