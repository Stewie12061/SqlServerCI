
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
SET @FormID = 'POSF0090';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Promotional Product Appling List';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.ConfirmUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.ConfirmUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.ConfirmDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.CreateUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.LastModifyUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm';
EXEC ERP9AddLanguage @ModuleID, 'POSF0090.IsConfirm' , @FormID, @LanguageValue, @Language;



------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;