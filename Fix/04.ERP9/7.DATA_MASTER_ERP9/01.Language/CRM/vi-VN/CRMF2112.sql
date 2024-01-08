-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2112- CRM
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
SET @FormID = 'CRMF2112';

SET @LanguageValue = N'Xem chi tiết dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LengthView', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.WidthView', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước/Cao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.HeightView', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá M2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia tờ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Infor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InforProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin in sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InforOffset', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InforTotalVariableFee', @FormID, @LanguageValue, @Language;
------------
SET @LanguageValue = N'Mẫu nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu màu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu MT sx ký';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ file /bản in (Dài)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ file/bản in (Rộng)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ file ctp/bản in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bao gồm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Include', @FormID, @LanguageValue, @Language;

----- 30/12/2020: Trọng Kiên: Bổ sung ngôn ngữ group công đoạn

SET @LanguageValue = N'Thông tin công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InforPhase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Con';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tờ chạy Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng Gsm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng  Tờ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng Ram';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng  Kg';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định Lượng M2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.GluingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.NoteDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MaterialGroupID', @FormID, @LanguageValue, @Language;