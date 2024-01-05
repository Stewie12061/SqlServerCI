-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2010- CSM
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
SET @Language = 'en-US ' 
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2020';

SET @LanguageValue = N'Update status fixes';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.GSXStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse Comtia Code';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.WHSymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.WHVMIResult', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test Cycles';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.GroupTestCycles', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 01';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 02';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 03';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 04';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 05';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 06';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 07';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 08';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 09';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 10';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 11';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 12';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 13';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 14';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Test 15';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Test15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.GroupOther', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 01';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 02';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 03';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 04';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 05';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 06';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 07';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 08';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 09';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other 10';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Other10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reimbursement part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.ReimbursementID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DepotBilling';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.DepotBillingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Billable';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.IsBillable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes Subject';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.NotesSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requote Notes';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.RequoteNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Escalate To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.EscalateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Obvious Damage';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.IsObviousDamage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Damage';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.TypeOfDamage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Issue';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.TypeOfIssue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Damage part description';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.DamageDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.EscalateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Escalate To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.EscalateToName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.ReimbursementID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reimbursement part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.ReimbursementName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.WHSymptomCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse Comtia';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.WHSymptomName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.WHVMIResult.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.WHVMIResultName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.DepotBillingID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Depot Billing Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.DepotBillingName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.GSXStatus.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.TypeOfIssue.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Issue';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.TypeOfIssueName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.TypeOfDamage.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Damage';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2020.TypeOfDamageName.CB', @FormID, @LanguageValue, @Language;