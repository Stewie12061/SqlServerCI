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
SET @FormID = 'LMF2052'

SET @LanguageValue  = N'Xem chi tiết hợp đồng bảo lãnh / LC'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.SubTitle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.SubTitle3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng hạn mức'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.LimitVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.ProjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.PurchaseContractName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bổ sung'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.SubTitle4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phong tỏa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.SubTitle5',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giải tỏa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.SubTitle6',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gửi mail'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số HĐ/Số LC'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CreditFormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo lãnh nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.IsAnswerable',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CostTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thu phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CostDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CostTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ phí (%)'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CostRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.ConvertedAmount_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CostTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.Notes_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.CostDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.LimitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.ConvertedAmount_LMT2053',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.Notes_LMT2053',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay (quy đổi)'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.LimitCAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lần gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2052.NumberRenewals',  @FormID, @LanguageValue, @Language;