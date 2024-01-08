------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MTF0070 - MT
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
SET @Language = 'en-US' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF3024';


SET @LanguageValue = N'SALES REPORT';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop/Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of coupons';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From saleman';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To saleman';
EXEC ERP9AddLanguage @ModuleID, 'POSF3024.ToSalesManName' , @FormID, @LanguageValue, @Language;





------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;