-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1132- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1132';
SET @LanguageValue = N'Detail inventory type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.ThongTinLoaiMatHang' , @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Description',  @FormID, @LanguageValue, @Language;
SET @Finished = 0;