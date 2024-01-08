-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2000- QC
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
SET @FormID = 'QCF2000';

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The date of the vote';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Votes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year of voting';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Measuring person';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Measuring person';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mechanic';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mechanic';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse assistant';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse assistant';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CN packaging';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CN packaging';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production GS';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production GS';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Auditor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 02';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritPOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production result summary';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritProductRes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritCheckOutPut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritProgressInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name (Customer)';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.PassRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.FailRate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.MachineName.CB', @FormID, @LanguageValue, @Language;
