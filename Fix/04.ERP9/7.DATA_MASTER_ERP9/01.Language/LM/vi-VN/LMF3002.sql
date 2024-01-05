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
SET @FormID = 'LMF3002'

SET @LanguageValue  = N'Báo cáo số dư tín dụng và lãi vay phải trả'
EXEC ERP9AddLanguage @ModuleID, 'LMF3002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF3002.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF3002.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF3002.CreditVoucherID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị hợp đồng đã tất toán'
EXEC ERP9AddLanguage @ModuleID, 'LMF3002.IsNotShowFinish',  @FormID, @LanguageValue, @Language;

