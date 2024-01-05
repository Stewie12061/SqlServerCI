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
SET @FormID = 'LMF3001'

SET @LanguageValue  = N'Báo cáo tổng hợp hạn mức'
EXEC ERP9AddLanguage @ModuleID, 'LMF3001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF3001.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'LMF3001.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày lập báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'LMF3001.ReportDate',  @FormID, @LanguageValue, @Language;
