-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2141- M
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
SET @FormID = 'MF2141';

SET @LanguageValue = N'Update production plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of production information';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.DescriptionSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InheritPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production information';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TabMT2141', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine information';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TabMT2142', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.VoucherNoProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production time';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Number', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion plan date';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.EndDatePlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion date';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product/Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time limit';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TimeLimit', @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'Total labor';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production time/day';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TimeNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StartDateManufacturing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Space (days)';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.SpaceTimes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StatusName.CB', @FormID, @LanguageValue, @Language;