-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2102- CRM
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
SET @FormID = 'CRMF2102';

SET @LanguageValue = N'Chi tiết phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InformationRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DetailRequirements', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin công đoạn sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT2104', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bổ sung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.AdditionalInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tiếp nhận thông tin';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tiếp nhận thông tin';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã market';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TG giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn thanh toán trong vòng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí vận chuyển (thuê xe)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đĩa CD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số SP/ tờ in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số SP/ khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy Offset';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy Offset';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gia công khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusFilmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusMoldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.RequiredContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ProductDimensions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy cách khổ in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy cách khổ giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StructuralInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trong vòng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FirstFromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ngày sau khi xác nhận mẫu & DDH.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastFromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ngày sau giao đủ hàng và hoá đơn GTGT.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastPaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Theo hợp đồng ký';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsContract01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsContract02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% ngay sau khi ký hợp đồng.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Percent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu khách hàng cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CustomerProvide', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bổ sung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.AdditionalInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthWidthInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết cấu giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperTexture', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách đóng hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PackingMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng trong';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UsedInName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng đựng trong thùng/hộp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tải trọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ chịu lực';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ bục';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chịu lực BCT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nén cạnh ECT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kiểu hộp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu nội dung theo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu màu theo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách đóng hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu pallet';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng trong';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương pháp in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt con/bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.GluingTypeName', @FormID, @LanguageValue, @Language;