-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2002- QC
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
SET @FormID = 'QCF2002';

SET @LanguageValue = N'Product quality voucher View';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The date of the vote';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Votes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year of voting';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Measurer code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Measuring person';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC employee code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mechanic code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mechanic';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse sub code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse assistant';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packaging CN code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CN packaging';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production GS code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production GS';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Auditor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 02';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritPOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritProductRes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original slip';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request release from warehouse';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritCheckOutPut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritProgressInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name (Customer)';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% pass rate';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.PassRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage of failure';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.FailRate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.HandlingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method Test';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.MethodTestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.QuantityInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test Quantity';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DParameter04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity QC';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.QuantityQC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity UnQC';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.QuantityUnQC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ReasonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Solution';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Solution', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Causal';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Causal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivered Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DeliveredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach picture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Target', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.MinValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.MaxValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test Value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.CheckValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Method', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test content';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ContentCheck', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Result', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluate';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ReasonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TabQCT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TabQCT20021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Property standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TabQCT20022', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TabQCT20023', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TabQCT20024', @FormID, @LanguageValue, @Language;