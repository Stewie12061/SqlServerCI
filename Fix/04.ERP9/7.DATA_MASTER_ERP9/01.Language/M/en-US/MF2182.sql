-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2182- M
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
SET @Language = 'en-US' 
SET @ModuleID = 'M';
SET @FormID = 'MF2182';

SET @LanguageValue = N'Packing requirement view';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selection of multi sales order';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory factory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InventoryFactoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch stamp';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.BranchTem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nest Code';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.NestCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product/box rate';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set/box';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Total', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Colors';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Colors', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.NumberColor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Branch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last day of delivery';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CancelDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing requirement information';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.YeuCauDongGoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing requirement details';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.ChiTietYeuCauDongGoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.DinhKem', @FormID, @LanguageValue, @Language;
