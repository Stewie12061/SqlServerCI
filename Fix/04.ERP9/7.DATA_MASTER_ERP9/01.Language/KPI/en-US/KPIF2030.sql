-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2030- KPI
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
SET @FormID = 'KPIF2030';

SET @LanguageValue = N'List of soft salary coefficients';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table Name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2030.TableName', @FormID, @LanguageValue, @Language;

