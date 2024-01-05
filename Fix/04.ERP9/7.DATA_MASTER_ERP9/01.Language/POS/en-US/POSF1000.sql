------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF1000 - POS
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF1000';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Title' , @FormID, @LanguageValue, @Language;



SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.ShopName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer address';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Disabled' , @FormID, @LanguageValue, @Language;