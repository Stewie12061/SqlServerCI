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
SET @FormID = 'LMF2070'

SET @LanguageValue  = N'Mã ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.BankID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.BankName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.StatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng hạn mức'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.LimitVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.ProjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.ProjectID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.ProjectName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sửa đổi hợp đồng bảo lãnh L/C'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.CreditFormID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.CreditFormName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.CreditFormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.CreditFormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gia hạn từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gia hạn đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.GuaranteeVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2070.VoucherDate',  @FormID, @LanguageValue, @Language;