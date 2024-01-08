-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1421- CI
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
SET @FormID = 'CIF1421';

SET @LanguageValue  = N'Update goods specificationsa'
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information on establishing goods specifications';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.QuyCachHangHoa',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Specification code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Specification name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.Description',  @FormID, @LanguageValue, @Language;