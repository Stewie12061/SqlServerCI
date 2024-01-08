-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2191- M
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
SET @FormID = 'MF2191';

SET @LanguageValue = N'Update finish product packing';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selection of multi sales orders';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order information';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.TabMT2191', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Components details';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.TabMT2192', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size (Production paper)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.SizeM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut (Production paper)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.CutM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size (Wave paper)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.SizeWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut (Wave paper)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.CutWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sheets';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import way';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.WayInside', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Box size';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.BoxSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Component ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.ComponentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Component';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.ComponentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.ComponentQuantity', @FormID, @LanguageValue, @Language;