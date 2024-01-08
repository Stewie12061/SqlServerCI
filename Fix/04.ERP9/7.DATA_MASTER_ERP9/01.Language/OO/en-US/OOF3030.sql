-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3030- OO
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
SET @FormID = 'OOF3030';

SET @LanguageValue = N'DivisionID';
EXEC ERP9AddLanguage @ModuleID, 'OOF3030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ProjectID';
EXEC ERP9AddLanguage @ModuleID, 'OOF3030.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project Norm Report';
EXEC ERP9AddLanguage @ModuleID, 'OOF3030.Title', @FormID, @LanguageValue, @Language;

