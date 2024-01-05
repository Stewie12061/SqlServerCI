-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2000- BEM
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
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2000';

SET @LanguageValue = N'List proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance /payment user ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK inherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APKInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve level';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving level';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete Flag';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Due Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance/payment user name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CurrentLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InheritType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DebitAccountID_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CreditAccountID_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.MethodPay_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherNoDNCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ObjectAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'View mode';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SearchMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ConvertedAdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.TypeID_Print', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formation sources';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FormationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.IsInherited_2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;
