-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1202- CI
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
SET @FormID = 'CIF1202';

SET @LanguageValue  = N'Detail VAT Group'
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information VAT group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.ThongTinNhomThue',  @FormID, @LanguageValue, @Language;

