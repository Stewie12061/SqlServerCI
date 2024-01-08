-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2162- M
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
SET @FormID = 'MF2162';

SET @LanguageValue = N'View details production order';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order date';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance production plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.InheritMT2140', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finished product code';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status name';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.OrderStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase name';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order type';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.CommandType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Command type';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.CommandType.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S11ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S12ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S13ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S14ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S15ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S16ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S17ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S18ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S19ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.S20ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lot number';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.SourceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process code';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ApporitionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.VersionBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total number of employees';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info product order';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info detail product order';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.DetailDT.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product info ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.InheritTableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.InheritVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.InheritTransactionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.APK_MT2143', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.StatusID', @FormID, @LanguageValue, @Language;