-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2086- M
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
SET @ModuleID = 'M';
SET @FormID = 'SOF2086';

SET @LanguageValue = N'選擇打印顔色';
EXEC ERP9AddLanguage @ModuleID, 'SOF2086.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顔色代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2086.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2086.AnaName', @FormID, @LanguageValue, @Language;

