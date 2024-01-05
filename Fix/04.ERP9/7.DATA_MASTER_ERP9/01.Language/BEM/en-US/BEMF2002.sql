-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2002- BEM
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
SET @FormID = 'BEMF2002';

SET @LanguageValue = N'Advance payment';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance /payment user ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'See details proposal voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK inherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.APKInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve level';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving level';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Due Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance/payment user name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CurrentLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InheritType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DebitAccountID_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CreditAccountID_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.MethodPay_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherNoDNCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ObjectAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'View mode';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.SearchMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ConvertedAdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeID_Print', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formation sources';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FormationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.IsInherited_2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ringi No';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details proposal voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ThongTinChiTietDNTT_DNTTTU_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal voucher no information';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ThongTinDNTT_DNTTTU_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DinhKem', @FormID, @LanguageValue, @Language;