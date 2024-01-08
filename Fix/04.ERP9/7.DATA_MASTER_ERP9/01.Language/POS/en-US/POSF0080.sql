
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF0080';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'List of receipts';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cashier';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.CashierID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cancellation status';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.DeleteFlg' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.MemberIDOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is deposit';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.IsDeposit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit deposit voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.InheritDepositButton' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.InheritVoucher' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;