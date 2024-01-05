
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
SET @FormID = 'POSF2010';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Deposit voucher list';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop / Event ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale man';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.SaleManID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Has made a coupon';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.IsInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The deposit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.BookingAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.EmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Package ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.PackageID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Package name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.PackageName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cancellation status';
EXEC ERP9AddLanguage @ModuleID, 'POSF2010.DeleteFlg' , @FormID, @LanguageValue, @Language;