-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'LM';
SET @FormID = 'LMF2050'

SET @LanguageValue  = N'Hợp đồng bảo lãnh / LC'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.BankID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.BankName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.StatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng hạn mức'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.LimitVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ProjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ProjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ProjectID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ProjectName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.CreditFormID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.CreditFormName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.CreditFormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.CreditFormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lần gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2050.NumberRenewals',  @FormID, @LanguageValue, @Language;