-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2142- M
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
SET @FormID = 'MF2142';

SET @LanguageValue = N'Production plan view';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of production information';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DescriptionSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InheritPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.VoucherNoProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production time';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Number', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion plan date';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.EndDatePlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion date';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product/Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time limit';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.TimeLimit', @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'Total labor';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production time/day';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.TimeNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StartDateManufacturing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Space (days)';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.SpaceTimes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production plan information';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'	Production information sheet';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DetailTTSX.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine information';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DetailMay.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StatusID', @FormID, @LanguageValue, @Language;