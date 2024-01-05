
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2055- OO
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
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2056';

SET @LanguageValue = N'全承認';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'状態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ApprovePersonNote' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アカウント番号';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アカウント名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座番号';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'口座番号';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貸金口座';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類のコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借金口座';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'中間アカウント';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.MediumAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払方法';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メソッドコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メソッド名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.PaymentName.CB', @FormID, @LanguageValue, @Language;
