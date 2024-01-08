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
SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2002';

SET @LanguageValue = N'立替金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替金額の対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'受益者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座名義';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.BankAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ConvertedRequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算用支出額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ConvertedSpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期限';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DeparmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'返金予定日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為替レート';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払方法';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払条件';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残りの金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支出金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.SpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議申請書の詳細';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ThongTinChiTietDNTT_DNTTTU_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議申請書の情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ThongTinDNTT_DNTTTU_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議申請書の詳細参照';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherNo', @FormID, @LanguageValue, @Language;
