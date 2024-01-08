-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1242- CI
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
SET @FormID = 'CIF1242';
SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.TabAT1328', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ThongTinHangKhuyenMai', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'View promotion details';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.Title', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotional code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.PromoteName', @FormID, @LanguageValue, @Language;

