-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2151- M
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
SET @FormID = 'MF2151';

SET @LanguageValue = N'Update production cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplies date';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SuppliesDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting employee ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting employee';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher status';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of production information';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of production order';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month period';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year period';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expectations';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TabOT2202', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Predictability';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TabOT2203', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Compare';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TabOT2205', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order iD';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EDetailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ApporitionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.PDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Change';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.IsChange', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material group ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Safe inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SafeQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual inventory	';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EndQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Intended';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.IntendedPickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order approvedt';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.PickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Suggestion';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SuggestQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity inherit';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.QuantityInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual quantity inherit';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ActualQuantityInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.OrderStatus.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.OrderStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialIDChange.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialNameChange.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.GroupName.CB', @FormID, @LanguageValue, @Language;