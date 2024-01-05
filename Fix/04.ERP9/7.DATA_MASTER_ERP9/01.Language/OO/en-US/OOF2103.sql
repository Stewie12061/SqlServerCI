-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2103- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2103';

SET @LanguageValue = N'Choose Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2103.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2103.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2103.DepartmentName', @FormID, @LanguageValue, @Language;
