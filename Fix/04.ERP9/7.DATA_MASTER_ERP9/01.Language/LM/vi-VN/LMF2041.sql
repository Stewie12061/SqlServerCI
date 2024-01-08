-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ LMF2041- LM
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'LM';
SET @FormID = 'LMF2041';

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chứng từ giải ngân';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.DisburseVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chứng từ giải ngân';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.DisburseVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng tín dụng';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.CreditVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng tín dụng';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.CreditVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.DisFromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền trả trước (nguyên tệ)';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.BeforeOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền trả trước (quy đổi)';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.BeforeConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lãi suất điều chỉnh (%)';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lãi phạt (%)';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.PunishRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.OrderNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật phiếu điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian vay';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustTimeFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'LMF2041.AdjustTimeToDate', @FormID, @LanguageValue, @Language;


