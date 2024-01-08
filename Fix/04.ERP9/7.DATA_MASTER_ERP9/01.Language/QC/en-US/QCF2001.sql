-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2001- QC
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
SET @FormID = 'QCF2001';

SET @LanguageValue = N'Product quality voucher Update';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher preparation month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher preparation year';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine manager ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine manager';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC staff ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machinist ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machinist';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse filler ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse filler';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing worker';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing worker';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production supervisor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeID06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production supervisor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeName06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 02';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InheritPOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production result summary';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InheritProductRes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InheritTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.TabQCT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.TabQCT20021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Property standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.TabQCT20022', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.TabQCT20023', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.TabQCT20024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.HandlingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method Test';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MethodTestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.QuantityInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test Quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DParameter04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity QC';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.QuantityQC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity UnQC';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.QuantityUnQC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ReasonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Solution';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Solution', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Causal';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Causal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivered Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DeliveredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach picture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Target', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MinValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MaxValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Drawing';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.OrderDrawing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SRange06';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.SRange06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SRange07';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.SRange07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1st Test Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.CheckValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2nd Test Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.CheckValue02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'3rd Test Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.CheckValue03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'4th Test Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.CheckValue04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'5th Test Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.CheckValue05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Method', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test content';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ContentCheck', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Result', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluate';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ReasonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FullName';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.FullName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InventoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.InventoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.HandlingID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.HandlingName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ReasonID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.ReasonName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MethodTestID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.MethodTestName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DeliveredID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivered';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.DeliveredName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2001.UnitName.CB', @FormID, @LanguageValue, @Language;