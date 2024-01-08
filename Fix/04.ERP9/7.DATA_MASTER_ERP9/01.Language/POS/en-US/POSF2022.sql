DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2022'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail request for payment'
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ConfirmDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ConfirmUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.SuggestTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.IsConfirmName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InMemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information request for payment';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ThongTinPhieuDeNghiChi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Details request for payment';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ChiTietPhieuDeNghiChi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify data';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.MemberNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InMemberIDOKIA',  @FormID, @LanguageValue, @Language;
