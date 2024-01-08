-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1091- OO
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
SET @FormID = 'OOF1091';

SET @LanguageValue = N'Update device info';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';							   
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.TypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.AreaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.AreaName.CB', @FormID, @LanguageValue, @Language;



