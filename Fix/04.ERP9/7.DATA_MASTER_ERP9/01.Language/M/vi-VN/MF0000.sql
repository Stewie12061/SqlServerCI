-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF0000- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF0000';

SET @LanguageValue = N'Loại CT Sắp xếp cont';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherSortCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT Tính thùng đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherParking', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT Đóng gói giao khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherParkingRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT Kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherManufacturingPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT Dự trù sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherProductOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT Phiếu thống kê kết quả sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherProductionResult', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT Đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherManufacturingOrder', @FormID, @LanguageValue, @Language;