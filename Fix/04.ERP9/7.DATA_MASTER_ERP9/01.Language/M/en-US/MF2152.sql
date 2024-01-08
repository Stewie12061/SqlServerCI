-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2152- M
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
SET @FormID = 'MF2152';

SET @LanguageValue = N'Production cost estimate view';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplies date';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.SuppliesDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting employee ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Petitioner';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of production information';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of production order';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reservation warehouse';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month period';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year period';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order iD';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.EDetailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ApporitionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.PDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Change';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.IsChange', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material group ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Safe inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.SafeQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual inventory	';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.EndQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Intended';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.IntendedPickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order approvedt';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.PickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Suggestion';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.SuggestQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity inherit';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.QuantityInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual quantity inherit';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ActualQuantityInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expectations information';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expectations details';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DetailDT.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Predictability information';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DetailTDT.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comparative information';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DetaiDC.gR', @FormID, @LanguageValue, @Language;