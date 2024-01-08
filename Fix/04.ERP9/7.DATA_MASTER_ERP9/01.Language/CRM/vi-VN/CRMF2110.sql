-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2110- CRM
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
SET @FormID = 'CRMF2110';

SET @LanguageValue = N'Danh mục dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.TotalAmount', @FormID, @LanguageValue, @Language;
