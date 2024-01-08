﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2011- QC
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
SET @Language = 'en-US'; 
SET @ModuleID = 'QC';
SET @FormID = 'QCF2011';

SET @LanguageValue = N'Scale product weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Five documents';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Entry form at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gross weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.GrossWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Net weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.NetWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finished product code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of finished product';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.BatchNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Machine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Auto scale';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.AutoScale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Choose';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Choose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.OtherUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.OtherQuantity', @FormID, @LanguageValue, @Language;