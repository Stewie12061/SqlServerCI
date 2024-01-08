-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF0030- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF0030';

SET @LanguageValue = N'分析程式碼的定義';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼的定義';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼的定義';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.CIF0030Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定義（越南文';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Tab03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Tab04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計分錄';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Tab01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Tab02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'依賴分析代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.ReTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定義（英文';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'限額管理';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.Tab05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原名';
EXEC ERP9AddLanguage @ModuleID, 'CIF0030.SystemName', @FormID, @LanguageValue, @Language;
