-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF10481- KPI
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
SET @FormID = 'KPIF10481';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.ParameterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.ParameterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is common';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Select parameters for the formula to calculate KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.Title', @FormID, @LanguageValue, @Language;

