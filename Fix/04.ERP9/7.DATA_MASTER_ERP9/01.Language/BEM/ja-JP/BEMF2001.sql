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
SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2001';

SET @LanguageValue = N'アカウント番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アカウント名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替金額の対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'受益者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アカウント番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座名義';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座名義';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ConvertedRequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算用支出額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ConvertedSpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貸金口座';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期限';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借金口座';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DeparmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'返金予定日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為替レート';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'継承';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Inherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請の継承';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritDNCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替申請の継承';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritDNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'中間アカウント';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.MediumAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払方法';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メソッドコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メソッド名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払条件';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'条項コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'条項名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残りの金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支出金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議申請書の更新';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherNo', @FormID, @LanguageValue, @Language;
