-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2050 
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

SET @FormID = 'QCF3000';
SET @LanguageValue = N'List of reports';
EXEC ERP9AddLanguage @ModuleID, 'QCF3000.Title', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'List of reports';
EXEC ERP9AddLanguage @ModuleID, 'ASOFTQC.Bao_cao', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Chart report';
EXEC ERP9AddLanguage @ModuleID, 'ASOFTQC.Bieu_do', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Print stamp';
EXEC ERP9AddLanguage @ModuleID, 'ASOFTQC.In_tem', @FormID, @LanguageValue, @Language;

SET @FormID = 'QCF3001';
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.Title', @FormID, N'Minutes of quality', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.ToDate', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.FromDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.ShiftID', @FormID, N'Shift', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.DepartmentID', @FormID, N'Workshop', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.MachineID', @FormID, N'Machine', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.InventoryID', @FormID, N'Inventory', @Language;

SET @FormID = 'QCF3002';
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.Title', @FormID, N'Tracking of materials', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.ToDate', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.FromDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.ShiftID', @FormID, N'Shift', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.DepartmentID', @FormID, N'Workshop', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.MachineID', @FormID, N'Machine', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.InventoryID', @FormID, N'Inventory', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.MaterialID', @FormID, N'Material', @Language;

SET @FormID = 'QCF3003';
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.Title', @FormID, N'Machine operation report', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.Date', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ToDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ShiftID', @FormID, N'Shift', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.DepartmentID', @FormID, N'Workshop', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.MachineID', @FormID, N'Machine', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.InventoryID', @FormID, N'Inventory', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ReportView.InventoryID.CB', @FormID, N'ID', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ReportView.InventoryName.CB', @FormID, N'Name', @Language;

SET @FormID = 'QCF3004';
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.Title', @FormID, N'Machine inspection minute', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.Date', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.ToDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.ShiftID', @FormID, N'Shift', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.DepartmentID', @FormID, N'Workshop', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.MachineID', @FormID, N'Machine', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.InventoryID', @FormID, N'Inventory', @Language;

SET @FormID = 'QCF3005';
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.Title', @FormID, N'Production report', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.ToDate', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.FromDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.ShiftID', @FormID, N'Shift', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.DepartmentID', @FormID, N'Workshop', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.MachineID', @FormID, N'Machine', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.InventoryID', @FormID, N'Inventory', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.GetPathTemplate', @FormID, N'Print template', @Language;
EXEC ERP9AddLanguage @ModuleID, 'GetPathTemplate', @FormID, N'Print template', @Language;

SET @FormID = 'QCF3006';
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.Title', @FormID, N'Minutes of defect remedying', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.ToDate', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.FromDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.MachineID', @FormID, N'Machine', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.InventoryID', @FormID, N'Inventory', @Language;


SET @FormID = 'QCF3007';
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.Title', @FormID, N'Chart of standards', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.ToDate', @FormID, N'From date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.FromDate', @FormID, N'To date', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.StandardID', @FormID, N'Standard', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.InventoryID', @FormID, N'Inventory', @Language;


SET @FormID = 'QCF3008';
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.Title', @FormID, N'Print stamp', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.DivisionID', @FormID, N'Division', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.BatchNo', @FormID, N'Batch no', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.InventoryID', @FormID, N'Inventory', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.APK', @FormID, N'Batch no-Inventory', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.GetPathTemplate', @FormID, N'Print template', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.Customer', @FormID, N'Customer', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.SCNumber', @FormID, N'SC Number', @Language;
EXEC ERP9AddLanguage @ModuleID, 'GetPathTemplate', @FormID, N'Print template', @Language;

