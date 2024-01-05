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
SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2000';

SET @LanguageValue = N'請求金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替金額の対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'受益者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座名義';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.BankAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ConvertedRequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算用支出額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ConvertedSpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期限';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DeparmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'返金予定日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為替レート';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払方法';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払条件';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残りの金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支出金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請書リスト';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherNo', @FormID, @LanguageValue, @Language;
