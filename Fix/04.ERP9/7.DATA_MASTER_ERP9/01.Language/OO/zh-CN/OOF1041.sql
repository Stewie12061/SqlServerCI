-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1041- OO
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
SET @FormID = 'OOF1041';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態名稱英文';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.StatusNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顯示順序';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.Color', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.StatusType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'系統狀況';
EXEC ERP9AddLanguage @ModuleID, 'OOF1041.SystemStatus', @FormID, @LanguageValue, @Language;

