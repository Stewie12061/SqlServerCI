-----------------------------------------------------------------------------------------------------
-- Script tạo message - MT
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US'; 
SET @ModuleID = 'MT';
SET @FormID = 'MTF0080';

SET @LanguageValue = N'Choose Object';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0080.MTF0080Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Object ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0080.ObjectID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Object Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0080.ObjectName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Search text';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0080.SearchText' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
