-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2101- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2101';

SET @LanguageValue = N'Update receipt schedule';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchaser order';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.POrderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.FormToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity (Standard unit)';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ConvertedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivered';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ShippedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remained';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 1';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 2';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 3';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 4';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 5';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 6';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 7';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 8';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 9';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 10';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 11';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 12';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 13';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 14';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 17';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 18';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 19';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 20';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 21';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 22';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 23';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 24';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 25';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 26';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 27';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 28';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 29';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 30';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity30', @FormID, @LanguageValue, @Language;