-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2110- M
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
SET @FormID = 'MF2110';

SET @LanguageValue = N'List of inventory structure';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure name';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure type';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.UnitID', @FormID, @LanguageValue, @Language;

