-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0002- SO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF0002';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 報價單CT類型（NC）';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationA', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 報價單CT類型（銷售）';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 報價單CT類型（KHCU）';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為加工訂單';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherOutSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售計劃 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSalesPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨進度 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherDeliveryProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產信息CT類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收貨進度單據類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherReceiveProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售訂單 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSaleOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 報價單CT類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'調整訂單CT類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherAdjustOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫請求單CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherOutOfStock', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價格表的公式類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSpreadSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'營業方案的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherBusinessPlan', @FormID, @LanguageValue, @Language;

