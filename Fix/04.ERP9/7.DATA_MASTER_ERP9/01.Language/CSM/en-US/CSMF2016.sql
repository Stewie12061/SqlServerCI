-----------------------------------------------------------------------------------------------------
 -- Script tạo ngôn ngữ CSMF2016- CSM
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
 SET @FormID = 'CSMF2016';

SET @LanguageValue = N'Choose Accessory';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2016.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2016.AccessoriesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2016.AccessoriesName', @FormID, @LanguageValue, @Language;
