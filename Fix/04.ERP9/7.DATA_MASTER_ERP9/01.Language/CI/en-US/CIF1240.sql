﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1240- CI
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
SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1240';

SET @LanguageValue = N'Discount inventory category';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotional code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1240.PromoteName', @FormID, @LanguageValue, @Language;

