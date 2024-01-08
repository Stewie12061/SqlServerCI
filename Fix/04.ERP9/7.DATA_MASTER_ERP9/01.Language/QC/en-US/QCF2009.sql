-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2009- QC
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
SET @FormID = 'QCF2009';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The date of the vote';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Votes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year of voting';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Measuring person';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Measuring person';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mechanic';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mechanic';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse assistant';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse assistant';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CN packaging';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CN packaging';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production GS';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production GS';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Auditor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 02';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritPOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritProductRes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original slip';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritCheckOutPut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritProgressInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name (Customer)';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.PassRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.FailRate', @FormID, @LanguageValue, @Language;

