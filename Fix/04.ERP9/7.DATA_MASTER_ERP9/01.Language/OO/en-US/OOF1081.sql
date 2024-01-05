-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1081- OO
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
SET @FormID = 'OOF1081';

SET @LanguageValue = N'Update violated working hours';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Penalty for willful violation (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.PunishViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.TableViolatedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Late hour percentage';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.NumberHourLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Penalty rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.PunishRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.Note', @FormID, @LanguageValue, @Language;
