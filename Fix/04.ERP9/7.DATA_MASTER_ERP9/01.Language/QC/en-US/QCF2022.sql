-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2022- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF2022';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date founded';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'First shift slip';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Erase';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.RefAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.APKMasterCB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.RefAPKDetail', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.APKDetailCB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.InventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Source no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.SourceNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.BatchNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Description', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Method ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Method', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Method name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MethodName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New InventoryID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewInventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewInventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewBatchID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialUnitID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes01', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes02', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes03', @FormID, @LanguageValue, @Language;


--Combo Detail
SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Source no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.SourceNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.BatchNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Description.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.InventoryID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.InventoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.UnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handling of defective items voucher info';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail info';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List handling of defective items';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MethodName', @FormID, @LanguageValue, @Language;