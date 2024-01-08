-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2220- M
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
SET @FormID = 'MF2220';

SET @LanguageValue = N'List Order Production';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Date';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit SO';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsInheritSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit BOM';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Link No';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.LinkNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ref Infor';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.RefInfor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Period';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.PeriodID', @FormID, @LanguageValue, @Language;