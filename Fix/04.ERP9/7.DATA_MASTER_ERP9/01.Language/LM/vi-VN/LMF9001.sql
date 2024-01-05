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
SET @FormID = 'LMF9001'

SET @LanguageValue  = N'Chọn hợp đồng tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.FromDate',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.ToDate',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.CurrencyName',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Tổng tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.OriginalLimitTotal',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'LMF9001.Description',  @FormID, @LanguageValue, @Language;


