-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2160- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2160';

SET @LanguageValue  = N'Category Commission'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'into money';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.RevenueAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Items';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract/Invoice';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment Amount (Not VAT)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commission calculation amount';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead has not joined the Firm yet';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead has joined';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Coach';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ky';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Year'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.TranYear',  @FormID, @LanguageValue, @Language;
