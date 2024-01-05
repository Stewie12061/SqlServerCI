-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1222- CI
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
SET @FormID = 'CIF1222';

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Created user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Created date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zone view';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zone information';
EXEC ERP9AddLanguage @ModuleID, N'CIF1222.ThongTinKhuVuc', @FormID, @LanguageValue , @Language;