-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2130- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2130';

SET @LanguageValue = N'List of production processes ';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process name';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process time';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.RoutingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;