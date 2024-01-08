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

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer code';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit SO';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsInheritSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit BOM';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subjects of THCP';
EXEC ERP9AddLanguage @ModuleID, 'MF2220.PeriodID', @FormID, @LanguageValue, @Language;

