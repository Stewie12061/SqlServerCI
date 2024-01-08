-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2103- CRM
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
SET @FormID = 'CRMF2103';

SET @LanguageValue = N'Kế thừa mẫu in cũ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tiếp nhận thông tin';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tiếp nhận thông tin';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã market';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chất lượng sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí vận chuyển (thuê xe)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đĩa CD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số SP/ tờ in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số SP/ khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy Offset';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy Offset';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gia công khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xuất phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.RequiredContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước SP';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ProductDimensions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước khổ in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PrintS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước khổ giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaperS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.StructuralInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trong vòng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FirstFromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ngày sau khi xác nhận mẫu & DDH.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LastFromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ngày sau giao đủ hàng và hoá đơn GTGT.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LastPaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Theo hợp đồng ký';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsContract01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsContract02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% ngay sau khi ký hợp đồng.';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Percent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu khách hàng cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.CustomerProvide', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bổ sung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.AdditionalInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ phim';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LengthWidthInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết cấu giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaperTexture', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lưu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.lblBtnSave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Huỷ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.lblCacel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa mẫu in cũ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.btnInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'(Tối đa 250 ký tự)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.lblPlaceHolder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaperTypeName.CB', @FormID, @LanguageValue, @Language;