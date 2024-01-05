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
SET @FormID = 'POSR3010';


SET @LanguageValue = N'TABLE OF REVENUE COLLECTION WITH COLLECTION AND PAYMENT';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From member';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.FromMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To member';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.ToMemberID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;