
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
SET @FormID = 'LMF2051';

SET @LanguageValue  = N'Cập nhật hợp đồng bảo lãnh / LC'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Contract',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bổ sung'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Parameter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng hạn mức'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.LimitVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ProjectName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.PurchaseContractName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.PurchaseContractID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ProjectID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CreditFormID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số HĐ/Số LC'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CreditFormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CreditFormName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CreditFormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ProjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.PurchaseContractID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bão lãnh nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.IsAnswerable',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng hợp đồng vay để bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.IsUseLoanContract',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CostTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thu phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CostDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CostTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ phí(%)'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CostRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ConvertedAmount_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CostTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Notes_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.CostDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.LimitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ConvertedAmount_LMT2053',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Notes_LMT2053',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay(quy đổi)'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.LimitCAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.PurchaseContractName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa kế hoạch thu chi'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.IsInheritPlanPayment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.AnaID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.AnaName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.BankID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.BankName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.BankAccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.BankAccountNo.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tiền về'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2051.VoucherID',  @FormID, @LanguageValue, @Language;