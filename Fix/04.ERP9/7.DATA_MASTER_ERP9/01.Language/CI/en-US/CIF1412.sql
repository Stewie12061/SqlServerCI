-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1412- CI
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
SET @FormID = 'CIF1412';
SET @LanguageValue  = N'Danh mục thiết lập quy cách hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type name (English)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Surcharge';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.IsExtraFee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information on establishing goods specifications';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.ThongTinThietLapQCHH',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.Description',  @FormID, @LanguageValue, @Language;