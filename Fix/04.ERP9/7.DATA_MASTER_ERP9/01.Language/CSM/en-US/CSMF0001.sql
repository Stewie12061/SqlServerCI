-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF0001- OO
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF0001'

SET @LanguageValue  = N'CSM Module Setting'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Firm List'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.FirmAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model List'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ModelAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Product Type List'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ProductTypeAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'QC Staff'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.QCID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reason ID'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ReasonID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reason Name'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ReasonName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Technical Staff'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TechnicalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'GSX auto-check timming'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TimeCheck',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'GSX check couting'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Transport Type List'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TransportTypeAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analysis ID'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quotes Voucher Type'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherBG',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Repair Order Voucher Type'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherPSC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Receive Order Voucher Type'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherReceive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Delivery Order Voucher Type'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherSend',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher ID'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'The object of service, repair providing'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ObjectName',  @FormID, @LanguageValue, @Language;