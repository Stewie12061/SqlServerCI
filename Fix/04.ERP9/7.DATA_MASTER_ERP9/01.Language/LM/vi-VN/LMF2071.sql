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
SET @FormID = 'LMF2071'

SET @LanguageValue  = N'Sửa đổi hợp đồng bảo lãnh L/C'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Contract',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bổ sung'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Parameter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng hạn mức'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.LimitVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ProjectName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.PurchaseContractName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.PurchaseContractID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ProjectID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CreditFormID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số HĐ gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày HĐ gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã HĐ gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.VoucherID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CreditFormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CreditFormName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CreditFormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ProjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.PurchaseContractID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bão lãnh nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.IsAnswerable',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng hợp đồng vay để bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.IsUseLoanContract',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CostTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thu phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CostDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CostTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CostRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ConvertedAmount_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CostTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Notes_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.CostDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.LimitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ConvertedAmount_LMT2053',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Notes_LMT2053',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.GuaranteeVoucherID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.GuaranteeVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại điều chỉnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.AdjustedTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải Hợp đồng bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.GuaranteeDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'LMF2071.Description.CB',  @FormID, @LanguageValue, @Language;
