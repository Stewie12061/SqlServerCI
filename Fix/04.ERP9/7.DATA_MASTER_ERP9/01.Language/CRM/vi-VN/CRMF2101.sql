-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2101- CRM
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
SET @FormID = 'CRMF2101';

SET @LanguageValue = N'Phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tiếp nhận thông tin';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tiếp nhận thông tin';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã market';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí vận chuyển (thuê xe)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đĩa CD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số SP/ tờ in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số SP/ khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy Offset';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy Offset';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gia công khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.RequiredContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước SP';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ProductDimensions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước khổ in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước khổ giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaperS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StructuralInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trong vòng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FirstFromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ngày sau khi xác nhận mẫu & DDH.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastFromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ngày sau giao đủ hàng và hoá đơn GTGT.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastPaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Theo hợp đồng ký';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsContract01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsContract02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% ngay sau khi ký hợp đồng.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Percent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu khách hàng cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CustomerProvide', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bổ sung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AdditionalInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthWidthInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết cấu giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaperTexture', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lưu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.lblBtnSave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Huỷ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.lblCacel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa mẫu in cũ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.btnInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'(Tối đa 250 ký tự)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.lblPlaceHolder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitPrice.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách đóng hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu pallet';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng trong';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đựng trong thùng/hộp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tải trọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ chịu lực';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ bục';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chịu lực BCT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nén cạnh ECT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kiểu hộp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu nội dung theo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu màu theo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã LVKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên LVKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (tờ)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.NodeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.NodeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.GluingTypeName', @FormID, @LanguageValue, @Language;