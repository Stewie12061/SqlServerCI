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
SET @FormID = 'CSMF2013';

SET @LanguageValue = N'Firm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VoucherNo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dispatch';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Model1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Serial Number';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IMEI Number';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Symptom Code';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.SymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is Non Restore';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.IsNonRestore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receive Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.ReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'External VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.ExternalVMI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restore Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore01Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore01Result', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restore Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore02Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore02Result', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Employee01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Employee02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Check VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.GroupCheckVMI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restore 1';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.GroupRestore01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restore 2';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.GroupRestore02', @FormID, @LanguageValue, @Language;
