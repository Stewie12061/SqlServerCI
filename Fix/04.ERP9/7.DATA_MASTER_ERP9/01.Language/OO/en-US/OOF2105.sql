-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2105- OO
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
SET @FormID = 'OOF2105';

SET @LanguageValue = N'List the project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2105.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ProjectID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2105.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ProjectName';
EXEC ERP9AddLanguage @ModuleID, 'OOF2105.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'StartDate';
EXEC ERP9AddLanguage @ModuleID, 'OOF2105.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EndDate';
EXEC ERP9AddLanguage @ModuleID, 'OOF2105.EndDate', @FormID, @LanguageValue, @Language;

