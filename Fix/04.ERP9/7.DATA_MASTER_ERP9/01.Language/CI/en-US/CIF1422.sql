-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1422- CI
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
SET @FormID = 'CIF1422';

SET @LanguageValue  = N'See detailed product specifications'
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.StandardTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information on establishing goods specifications';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.QuyCachHangHoa',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.Description',  @FormID, @LanguageValue, @Language;