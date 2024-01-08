-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1082- OO
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
SET @FormID = 'OOF1082';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'表名';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'故意違規處罰（%）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.PunishViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'表格代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.TableViolatedID', @FormID, @LanguageValue, @Language;

