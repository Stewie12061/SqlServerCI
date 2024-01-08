
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
SET @FormID = 'POSF0082';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'List of receipts details';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cashier';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.CashierID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ConvertedAmount';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.DeleteFlg' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherited voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherNoInherited' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Orders' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.LastModifyDate' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'List of receipts information';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.TabThongTinPhieuThu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of receipts information details';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.TabPOST00802' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;