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
SET @FormID = 'LMF2072'

SET @LanguageValue  = N'Xem chi tiết Sửa đổi hợp đồng bảo lãnh L/C'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.SubTitle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.SubTitle3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng hạn mức'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.LimitVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.ProjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.PurchaseContractName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bổ sung'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.SubTitle4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phong tỏa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.SubTitle5',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giải tỏa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.SubTitle6',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gửi mail'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số HĐ gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CreditFormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày HĐ gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo lãnh nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.IsAnswerable',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian gia hạn'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CostTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thu phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CostDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CostTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CostRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.ConvertedAmount_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CostTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.Notes_LMT2052',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.CostDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.LimitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.Notes_LMT2073',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng bảo lãnh'
EXEC ERP9AddLanguage @ModuleID, 'LMF2072.GuaranteeVoucherNo',  @FormID, @LanguageValue, @Language;