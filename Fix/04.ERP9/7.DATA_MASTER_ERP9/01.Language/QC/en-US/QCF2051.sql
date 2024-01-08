
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2051 
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
SET @FormID = 'QCF2051';

SET @LanguageValue = N'Detail info';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TabQCT20101', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manufacturing date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranMonth';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranYear';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MachineName.CB', @FormID, @LanguageValue, @Language;

-- QCT20101 -----------------------------

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APKShift', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APKInventory', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APKMaster', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Manufacturing date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Source no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.SourceNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.BatchNo', @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialID', @FormID, N'Material ID' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialName', @FormID, N'Material name' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Description', @FormID, N'Description' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.QCT2001Description', @FormID, N'Description' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.BatchID', @FormID, N'Bacth no' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialID.CB', @FormID, N'Material ID' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialName.CB', @FormID, N'Material name' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryID.CB', @FormID, N'Inventory ID' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryName.CB', @FormID, N'Inventory name' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.BatchNo.CB', @FormID, N'Bacth no' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.SourceNo.CB', @FormID, N'Source no' , @Language;

SET @LanguageValue = N'Machine chief';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName01.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC Employee';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName02.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Machinist';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName03.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Warehouse filler';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName04.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Packing worker';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName05.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Production supervisor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName06.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tracking of materials voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Title', @FormID, @LanguageValue, @Language;

