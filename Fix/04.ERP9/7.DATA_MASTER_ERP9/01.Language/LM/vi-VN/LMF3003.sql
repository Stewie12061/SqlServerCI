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
SET @FormID = 'LMF3003'

SET @LanguageValue  = N'Báo cáo vay vốn theo hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF3003.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF3003.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF3003.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức tín dụng'
EXEC ERP9AddLanguage @ModuleID, 'LMF3003.CreditFormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày lập báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'LMF3003.ReportDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị hợp đồng đã tất toán'
EXEC ERP9AddLanguage @ModuleID, 'LMF3003.IsNotShowFinish',  @FormID, @LanguageValue, @Language;
