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
SET @FormID = 'POSF3023';


SET @LanguageValue = N'TABLE OF SELLING GOODS SERVICE';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop/Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of deposit';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From saleman';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To saleman';
EXEC ERP9AddLanguage @ModuleID, 'POSF3023.ToSalesManName' , @FormID, @LanguageValue, @Language;





------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;