-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2021 
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
SET @Language = 'en-US ' 
SET @ModuleID = 'QC';
SET @FormID = 'QCF2021';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manufacturing date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranMonth';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranYear';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.RefAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.APKMasterCB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.RefAPKDetail', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.APKDetailCB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.InventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Source no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.SourceNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.BatchNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Description', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Method ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Method', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Method name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MethodName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New InventoryID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewInventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewInventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'New batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewBatchID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialUnitID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Material quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes01', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes02', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes03', @FormID, @LanguageValue, @Language;


--Combo Detail
SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Source no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.SourceNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.BatchNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Description.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.InventoryID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.InventoryName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.UnitID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Method';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MethodName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'List handling of defective items';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Title', @FormID, @LanguageValue, @Language;


