-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2181- M
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
SET @FormID = 'MF2181';

SET @LanguageValue = N'Update packing requirement';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selection of multi sales order';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory factory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.InventoryFactoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch stamp';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.BranchTem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nest Code';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.NestCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product/box rate';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set/box';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Total', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Colors';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Colors', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.NumberColor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Branch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last day of delivery';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CancelDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'MF2181.CountryID.CB', @FormID, @LanguageValue, @Language;
