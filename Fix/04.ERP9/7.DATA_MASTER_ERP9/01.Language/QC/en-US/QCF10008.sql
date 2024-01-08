-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10008- QC
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
SET @FormID = 'QCF10008';

SET @LanguageValue = N'Choose batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.APK', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.VoucherNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DivisionID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.VoucherDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'PLU';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.InventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'TranMonth';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TranMonth', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lot number';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.SourceNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'TranYear';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TranYear', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.BatchNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.ShiftID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.Description', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.MachineID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DepartmentID', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DepartmentName', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Machine chief';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.EmployeeID01', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'QC Employee';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.EmployeeID02', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Machinist';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.EmployeeID03', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Warehouse filler';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.EmployeeID04', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Packing worker';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production supervisor';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.EmployeeID06', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.Description', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 02';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.Notes03', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.Status', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TypeID', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'ParentID';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.ParentID', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail info';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TabQCT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size standards';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TabQCT20021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Properties standards';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TabQCT20022', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance standards';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TabQCT20023', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing standards';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.TabQCT20024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source no';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.SourceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.BatchNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ParentID';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.ParentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Auto scale';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.AutoScale', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Gross weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.GrossWeight', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Net weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.NetWeight', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'A';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DParameter01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'B';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DParameter02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'C';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DParameter03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample number';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DParameter04', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QCSS';
EXEC ERP9AddLanguage @ModuleID, 'QCF10008.DParameter05', @FormID, @LanguageValue, @Language;