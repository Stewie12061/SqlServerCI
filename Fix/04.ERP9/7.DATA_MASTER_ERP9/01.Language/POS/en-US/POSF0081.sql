
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF0081';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Update ist of receipts';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cashier';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.CashierID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ConvertedAmount';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.DeleteFlg' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not inherited voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherNoInherited' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Orders' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit sales order';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.InheritButton' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount to be collected';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is deposit';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.IsDeposit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberIDOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberNameOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deposit voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.DepositVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment form ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PaymentName01.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment form name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PaymentName02.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Inherit deposit voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.InheritDepositButton' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is inherit deposit?';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.IsDeposit.POS' , @FormID, @LanguageValue, @Language;


------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;