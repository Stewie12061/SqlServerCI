-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2061- QC
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
SET @FormID = 'QCF2061';

SET @LanguageValue = N'Statistical screen';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Goods';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.BatchNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.StandardParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Standard', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Quality control';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.TabQCT2071', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.TabQCT2072', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handling of defective items';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.TabQCT2073', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Date_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.ShiftName_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.MachineName_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.InventoryID_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.InventoryName_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.BatchNo_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.UnitName_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gross weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.GrossWeight_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Net weight';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.NetWeight_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Notes01_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 02';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Notes02_Tab1andard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Notes03_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Status_Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Date_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.ShiftName_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Time_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.MachineName_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.InventoryName_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.BatchNo_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.MaterialID_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.MaterialName_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.BatchNo2050_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.UnitName_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Time2050_Tab2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Date_Tab3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.InventoryName_Tab3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.BatchNo_Tab3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Description_Tab3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Method_Tab3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.NewInventoryName_Tab3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.NewBatchNo_Tab3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conclude';
EXEC ERP9AddLanguage @ModuleID, 'QCF2061.Notes_Tab3', @FormID, @LanguageValue, @Language;
