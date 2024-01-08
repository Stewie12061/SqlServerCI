﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1541- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1541';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gửi ý kiến phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.IsUsed', @FormID, @LanguageValue, @Language;

