------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1110 
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1110';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Category payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1110.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1110.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Payment code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1110.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1110.PaymentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1110.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1110.Disabled' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;