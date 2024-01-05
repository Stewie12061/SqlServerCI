-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2161- M
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
SET @FormID = 'MF2161';

SET @LanguageValue = N'Update production order';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VoucherNo';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product info ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order date';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance production plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.InheritMT2140', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.OrderStatus.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status name';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.OrderStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase name';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order type';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.CommandType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Command type';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.CommandType.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance production plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MPlanID', @FormID, @LanguageValue, @Language;