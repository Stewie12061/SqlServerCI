-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2001- BEM
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
SET @FormID = 'BEMF2001';

SET @LanguageValue = N'Advance payment';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance /payment user ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update list proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK inherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.APKInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve level';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving level';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Due Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance/payment user name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrentLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DebitAccountID_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreditAccountID_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.MethodPay_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherNoDNCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ObjectAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'View mode';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SearchMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ConvertedAdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.TypeID_Print', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formation sources';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FormationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.IsInherited_2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ringi No';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;