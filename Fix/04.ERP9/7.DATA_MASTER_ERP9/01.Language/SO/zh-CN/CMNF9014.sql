-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF9014- SO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'SO';
SET @FormID = 'CMNF9014';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9014.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9014.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9014.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9014.Notes', @FormID, @LanguageValue, @Language;

