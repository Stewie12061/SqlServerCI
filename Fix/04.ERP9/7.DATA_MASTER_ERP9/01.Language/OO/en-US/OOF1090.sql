-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1090- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF1090';

SET @LanguageValue = N'List of device';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DivisionID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Device ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DeviceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DeviceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DeviceNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.AreaID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Common use';							   
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.LastModifyDate', @FormID, @LanguageValue, @Language;



