-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1000- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1000';

SET @LanguageValue = N'List of Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From score';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.FromScore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To score';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.ToScore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.Classification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bonus rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.BonusRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1000.LastModifyDate', @FormID, @LanguageValue, @Language;

