-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF0003- CSM
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
SET @FormID = 'CSMF0003';

SET @LanguageValue = N'Choose User';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0003.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0003.UserName', @FormID, @LanguageValue, @Language;