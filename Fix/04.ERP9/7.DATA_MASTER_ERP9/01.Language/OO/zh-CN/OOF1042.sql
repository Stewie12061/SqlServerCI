-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1042- OO
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
SET @FormID = 'OOF1042';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態名稱英文';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顯示順序';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Color', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'系統狀況';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.SystemStatus', @FormID, @LanguageValue, @Language;

