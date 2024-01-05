-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2110A -  SO
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
SET @FormID = 'CRMF2110A';

SET @LanguageValue = N'Danh mục dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí Nguyên vật liệu & Nhân công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalAdjustment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí Nguyên vật liệu & Nhân công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalAdjustment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalAdjustmentPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước hộp/cm3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.BoxSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí vận chuyển/cm3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalShipping', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng (Bao gồm Duty)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalDuty', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.TotalSellingPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chỉnh hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.ScrapPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập %';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.SetupTimePercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập(Hao hụt)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.SetupTime500', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập(Hao hụt)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.PercentAdjustment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.PercentAdjustment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.Fee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm thuế suất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.DutyPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm tăng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.UpPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110A.DeliveryAddress', @FormID, @LanguageValue, @Language;