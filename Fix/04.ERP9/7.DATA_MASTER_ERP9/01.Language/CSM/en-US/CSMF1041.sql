
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0405- OO
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF1041';

SET @LanguageValue = N'Update Des Product';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Des Product ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.DesProductID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents of Des Product';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.ModelID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.Iscommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.ModelID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.ModelName.CB' , @FormID, @LanguageValue, @Language;