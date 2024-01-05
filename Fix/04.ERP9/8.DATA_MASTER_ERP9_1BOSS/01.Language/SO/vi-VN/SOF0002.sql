------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0002 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF0002';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Thiết lập mặc định';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT phiếu báo giá (NC) ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationA' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Loại CT phiếu báo giá (Sale) ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Loại CT phiếu báo giá (KHCU) ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationC' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Là đơn hàng gia công';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherOutSource' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT kế hoạch bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSalesPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT tiến độ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherDeliveryProgress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherProductInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm xem báo giá SALE không cần duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.GroupRoleID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.GroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.GroupName.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Loại CT tiến độ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherReceiveProgress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSaleOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT đơn hàng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherAdjustOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT phiếu yêu cầu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherOutOfStock' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT bảng tính giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSpreadSheet' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT phương án kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherBusinessPlan' , @FormID, @LanguageValue, @Language;