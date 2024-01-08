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
SET @Language = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF0002';

SET @LanguageValue = N'System settings';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT quotation (NC) ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationA', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT quotation (Sale) ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT quotation (KHCU) ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotationC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Processing orders ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherOutSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT sales plan';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSalesPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT delivery progress';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherDeliveryProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT product info';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CT type Delivery progress';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherReceiveProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group view the quotation SALE without approval';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.GroupRoleID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.GroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.GroupName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT receive progress';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherReceiveProgress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT sale order';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSaleOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT quotation';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherQuotation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT adjust order';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherAdjustOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT out of stock';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherOutOfStock', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT price spreadsheet';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherSpreadSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business plan CT';
EXEC ERP9AddLanguage @ModuleID, 'SOF0002.VoucherBusinessPlan', @FormID, @LanguageValue, @Language;

