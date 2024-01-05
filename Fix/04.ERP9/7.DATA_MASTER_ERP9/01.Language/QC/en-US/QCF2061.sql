--delete  A00001 where FormID  =N'QCF2061'

-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2061 
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

DECLARE @KeyID VARCHAR(100)
DECLARE @Text NVARCHAR(4000)
DECLARE @CustomName NVARCHAR(4000)

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Title'
SET @FormID = N'QCF2061'
SET @Text = N'Statistical screen'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.DivisionID'
SET @FormID = N'QCF2061'
SET @Text = N'Division'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.FromDate'
SET @FormID = N'QCF2061'
SET @Text = N'From date'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ToDate'
SET @FormID = N'QCF2061'
SET @Text = N'To date'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ShiftID'
SET @FormID = N'QCF2061'
SET @Text = N'Shift'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MachineID'
SET @FormID = N'QCF2061'
SET @Text = N'Machine'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Status'
SET @FormID = N'QCF2061'
SET @Text = N'Status'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryID'
SET @FormID = N'QCF2061'
SET @Text = N'Inventory'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo'
SET @FormID = N'QCF2061'
SET @Text = N'Batch no'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.StandardParent'
SET @FormID = N'QCF2061'
SET @Text = N'Standard type'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Standard'
SET @FormID = N'QCF2061'
SET @Text = N'Standard'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.TabQCT2071'
SET @FormID = N'QCF2061'
SET @Text = N'Quality control'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.TabQCT2072'
SET @FormID = N'QCF2061'
SET @Text = N'Material standard'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.TabQCT2073'
SET @FormID = N'QCF2061'
SET @Text = N'Handling of defective items'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Date_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Date'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ShiftName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Shift'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MachineName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Machine'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryID_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Inventory ID'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Inventory name'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Batch no'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.UnitName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Unit'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.GrossWeight_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Gross weight'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.NetWeight_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Net weight'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes01_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Notes 01'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes02_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Notes 02'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes03_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Notes 03'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Status_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Status'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Date_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Voucher date'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ShiftName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Shift'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Time_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Time'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MachineName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Machine'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Inventory ID'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Batch no'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MaterialID_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Material ID'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MaterialName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Material name'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo2050_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Material batch'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.UnitName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Material unit'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Time2050_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Time'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Date_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Date'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryName_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Inventory ID'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Batch no'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Description_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Reason'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Method_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Method'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.NewInventoryName_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'New inventory'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.NewBatchNo_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'New batch'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Conclude'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

GO