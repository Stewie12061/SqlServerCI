-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2010- QC
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
SET @FormID = 'QCF2010';

SET @LanguageValue = N'Scale product weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Five documents';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Entry form at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gross weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.GrossWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Net weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.NetWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.VoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.BatchNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2010.VoucherDate.CB', @FormID, @LanguageValue, @Language;
