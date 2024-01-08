-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1080- OO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF1080';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'表名';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'故意違規的處罰';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.PunishViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'表格代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.TableViolatedID', @FormID, @LanguageValue, @Language;

